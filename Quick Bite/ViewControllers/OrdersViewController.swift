//
//  OrdersViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        session_id = DataBaseQueries.getSessionID()
        ordersList = DataBaseQueries.getOrders(session_id: session_id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var session_id: Int = 0
    var ordersList: OrderList! {
        didSet {
            self.tabBarItem.badgeValue = ordersList.orders.count > 0 ? String(ordersList.orders.count) : nil
            ordersListTable.isHidden = ordersList.orders.count > 0 ? false : true
            billView.isHidden = ordersList.orders.count > 0 ? false : true
            ordersList.orders.count > 0 ? payButton.setTitle("Choose payment method ▸", for: .normal) : payButton.setTitle("Exit", for: .normal)
            itemTotal = 0
            for (_, order) in ordersList.orders {
                for item in order {
                    itemTotal += item.order_qty * item.order_price
                }
            }
            ordersListTable.reloadData()
        }
    }
    var itemTotal = 0 {
        didSet{ 
            textFieldDidEndEditing(discountField)
        }
    }
    
    weak var dismissDelegate: DismissDelegate?
    
    let ordersListTable = UITableView()
    let ordersLabel = UILabel()
    let billView = UIView()
    let payButton = UIButton()
    
    let horizontalStackView = UIStackView()
    let leftStackView = UIStackView()
    let rightStackView = UIStackView()
    
    let itemTotalLabel = UILabel()
    let taxLabel = UILabel()
    let discountField = UITextField()
    let grandTotalLabel = UILabel()
    
    let itemTotalAmount = UILabel()
    let discountAmount = UILabel()
    let taxAmount = UILabel()
    let grandTotalAmount = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
        self.setupHideKeyboardOnTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setViews(){
        
        view.addSubview(ordersLabel)
        view.addSubview(ordersListTable)
        view.addSubview(billView)
        view.addSubview(payButton)
        
        billView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(leftStackView)
        horizontalStackView.addArrangedSubview(rightStackView)
        
        leftStackView.addArrangedSubview(itemTotalLabel)
        leftStackView.addArrangedSubview(discountField)
        leftStackView.addArrangedSubview(taxLabel)
        leftStackView.addArrangedSubview(grandTotalLabel)
        
        rightStackView.addArrangedSubview(itemTotalAmount)
        rightStackView.addArrangedSubview(discountAmount)
        rightStackView.addArrangedSubview(taxAmount)
        rightStackView.addArrangedSubview(grandTotalAmount)
    }
    
    func setConstraints(){
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        ordersLabel.text = "Orders"
        ordersLabel.numberOfLines = 0
        ordersLabel.font = .boldSystemFont(ofSize: 22)
        ordersLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        ordersLabel.adjustsFontForContentSizeCategory = true
        ordersLabel.textAlignment = .left
        ordersLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        ordersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        ordersLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        ordersListTable.delegate = self
        ordersListTable.dataSource = self
        ordersListTable.allowsSelection = false
        ordersListTable.isUserInteractionEnabled = true
        ordersListTable.separatorStyle = .none
        ordersListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        ordersListTable.translatesAutoresizingMaskIntoConstraints = false
        ordersListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        ordersListTable.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor, constant: 8).isActive = true
        ordersListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        ordersListTable.bottomAnchor.constraint(equalTo: billView.topAnchor, constant: -8).isActive = true
        ordersListTable.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        ordersListTable.register(OrdersSectionHeader.self, forHeaderFooterViewReuseIdentifier: "OrdersSectionHeader")
        
        billView.layer.cornerRadius = 7.0
        billView.layer.masksToBounds = false
        billView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        billView.layer.shadowOffset = CGSize(width: 0, height: 0)
        billView.layer.shadowOpacity = 0.8
        billView.backgroundColor = .white
        billView.translatesAutoresizingMaskIntoConstraints = false
        billView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        billView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        billView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -8).isActive = true
        billView.heightAnchor.constraint(equalTo: billView.widthAnchor, multiplier: 0.3).isActive = true
        
        ordersList.orders.count > 0 ? payButton.setTitle("Choose payment method ▸", for: .normal) : payButton.setTitle("Exit", for: .normal)
        payButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        payButton.setTitleColor(.white, for: .normal)
        payButton.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        payButton.tintColor = .white
        payButton.layer.cornerRadius = 17
        payButton.titleLabel?.textAlignment = .center
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        payButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        payButton.addTarget(self, action: #selector(payButtonTap), for: .touchUpInside)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        horizontalStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leftAnchor.constraint(equalTo: billView.leftAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: billView.topAnchor).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: billView.rightAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: billView.bottomAnchor).isActive = true
        
        leftStackView.axis = .vertical
        leftStackView.alignment = .leading
        leftStackView.distribution = .fillProportionally
        
        rightStackView.axis = .vertical
        rightStackView.alignment = .trailing
        rightStackView.distribution = .fillProportionally
        
        itemTotalLabel.text = "Item Total"
        itemTotalLabel.font = .systemFont(ofSize: 14)
        
        discountField.placeholder = "Enter Discount Code..."
        discountField.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        discountField.font = .boldSystemFont(ofSize: 14)
        discountField.returnKeyType = UIReturnKeyType.done
        discountField.textColor = .systemBlue
        discountField.autocorrectionType = UITextAutocorrectionType.no
        discountField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        discountField.translatesAutoresizingMaskIntoConstraints = false
        discountField.rightAnchor.constraint(equalTo: leftStackView.rightAnchor, constant: -8).isActive = true
        discountField.delegate = self
        
        taxLabel.text = "Taxes and Charges"
        taxLabel.font = .systemFont(ofSize: 14)
        
        grandTotalLabel.text = "Grand Total"
        grandTotalLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        itemTotalAmount.text = "₹\(Double(itemTotal) + 0.0)"
        itemTotalAmount.textAlignment = .right
        itemTotalAmount.font = .systemFont(ofSize: 14)
        
        discountAmount.text = "₹\(0)"
        discountAmount.textAlignment = .right
        discountAmount.font = .boldSystemFont(ofSize: 14)
        
        taxAmount.text = "₹\(Double(itemTotal) * 0.05)"
        taxAmount.textAlignment = .right
        taxAmount.font = .systemFont(ofSize: 14)
        
        grandTotalAmount.text = "₹\(Double(itemTotal) + Double(itemTotal) * 0.05)"
        grandTotalAmount.textAlignment = .right
        grandTotalAmount.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersList.orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.orders[ordersList.orders.count - section - 1]!.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OrdersSectionHeader") as? OrdersSectionHeader
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .full
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800)
        let date = dateFormatter.date(from: (ordersList.orders[ordersList.orders.count - section - 1]?[0].order_date)!)
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        header?.timeLabel.text = "\(dateFormatter.string(from: date!))"
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
        cell.order = ordersList.orders[ordersList.orders.count - indexPath.section - 1]?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func payButtonTap(){
        
        let alert = UIAlertController(title: "Your Payment is Successful", message: "You have paid \(grandTotalAmount.text!)\n You saved \(discountAmount.text!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                                      //print("Yay! You brought your towel!")
                                      self.dismiss(animated: true,completion: {
                                          self.dismissDelegate?.didDismiss()
                                      })
                                  }))
        self.present(alert, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .systemBlue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        _ = textFieldShouldReturn(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text == "ZOHO10" {
            discountAmount.textColor = #colorLiteral(red: 0, green: 0.6409886479, blue: 0, alpha: 1)
            textField.textColor = #colorLiteral(red: 0, green: 0.6409886479, blue: 0, alpha: 1)
            updateBillLabels(itemTotal: Double(itemTotal), discount: 10)
        }
        else if textField.text == "" {
            discountAmount.textColor = .black
            updateBillLabels(itemTotal: Double(itemTotal), discount: 0)
            return true
        }
        else{
            textField.textColor = .systemRed
            discountAmount.textColor = .black
            updateBillLabels(itemTotal: Double(itemTotal), discount: 0)
        }
        return true
    }
    
    func updateBillLabels(itemTotal: Double, discount: Double){
        itemTotalAmount.text = "₹\(String(format:"%.2f",Double(itemTotal) + 0.0))"
        discountAmount.text = "₹\(String(format:"%.2f",Double(itemTotal) * discount/100))"
        taxAmount.text = "₹\(String(format:"%.2f",(Double(itemTotal) * (100-discount)/100) * 0.05))"
        grandTotalAmount.text = "₹\(String(format:"%.2f",Double(itemTotal * (100-discount)/100) + Double(itemTotal * (100-discount)/100) * 0.05))"
    }
    
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}


class OrdersSectionHeader: UITableViewHeaderFooterView{
    
    let timeLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        timeLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        timeLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        timeLabel.sizeToFit()
        timeLabel.textAlignment = .left
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
