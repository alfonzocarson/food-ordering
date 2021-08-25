//
//  OrdersViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SyncItems {
    
    var ordersList: OrderList! {
        didSet {
            self.tabBarItem.badgeValue = ordersList.orders.count > 0 ? String(ordersList.orders.count) : nil
            ordersListTable.reloadData()
        }
    }
    
    var session_id: Int = 0
    
    var ordersListTable = UITableView()
    var ordersLabel = UILabel()
    
    weak var delegate2: SyncItems?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    func setViews(){
        
        view.addSubview(ordersLabel)
        view.addSubview(ordersListTable)
    }
    
    func setConstraints(){
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        ordersLabel.text = "Orders"
        ordersLabel.numberOfLines = 0
        ordersLabel.font = .boldSystemFont(ofSize: 24)
        ordersLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        ordersLabel.adjustsFontForContentSizeCategory = true
        ordersLabel.textAlignment = .center
        ordersLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        ordersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        ordersLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        ordersListTable.delegate = self
        ordersListTable.dataSource = self
        ordersListTable.allowsSelection = false
        ordersListTable.isUserInteractionEnabled = true
        ordersListTable.separatorStyle = .none
        ordersListTable.isUserInteractionEnabled = true
        ordersListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        ordersListTable.translatesAutoresizingMaskIntoConstraints = false
        ordersListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        ordersListTable.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor, constant: 16).isActive = true
        ordersListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        ordersListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        ordersListTable.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        ordersListTable.register(OrdersSectionHeader.self, forHeaderFooterViewReuseIdentifier: "OrdersSectionHeader")
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
    
    func syncItems() {
        ordersList = DataBaseQueries.getOrders(session_id: session_id)
        print("Reloaded orderlist")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
