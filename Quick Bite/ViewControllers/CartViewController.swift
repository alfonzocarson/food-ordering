//
//  CartViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateItems, SyncItems {
    
    var cartList = [Item](){
        didSet{
            cartListTable.reloadData()
            self.tabBarItem.badgeValue = cartList.count > 0 ? String(cartList.count) : nil
            var cartTotal = 0
            for item in cartList {
                cartTotal += item.price * item.qty
            }
            orderButton.isHidden = cartList.count == 0 ? true : false
            cartValue.text = cartList.count > 0 ? "Total = ₹ \(cartTotal)" : "Your Food Cart is Empty"
        }
    }
    
    weak var delegate: SyncItems?
    
    let cartLabel = UILabel()
    let cartListTable = UITableView()
    let cartValue = UILabel()
    let orderButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setViews()
        setConstraints()
    }
    
    func setViews(){
        view.addSubview(cartLabel)
        view.addSubview(cartListTable)
        view.addSubview(cartValue)
        view.addSubview(orderButton)
    }
    
    func setConstraints(){
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        cartLabel.text = "Cart 🛒"
        cartLabel.numberOfLines = 0
        cartLabel.font = .boldSystemFont(ofSize: 24)
        cartLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        cartLabel.adjustsFontForContentSizeCategory = true
        cartLabel.textAlignment = .center
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        cartLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        cartLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        cartLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        cartListTable.delegate = self
        cartListTable.dataSource = self
        cartListTable.allowsSelection = false
        cartListTable.isUserInteractionEnabled = true
        cartListTable.allowsSelection = false
        cartListTable.separatorStyle = .none
        cartListTable.isUserInteractionEnabled = true
        cartListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        cartListTable.translatesAutoresizingMaskIntoConstraints = false
        cartListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        cartListTable.topAnchor.constraint(equalTo: cartLabel.bottomAnchor, constant: 16).isActive = true
        cartListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        cartListTable.bottomAnchor.constraint(equalTo: cartValue.topAnchor, constant: -16).isActive = true
        cartListTable.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        
        cartValue.font = .boldSystemFont(ofSize: 20)
        cartValue.textAlignment = .center
        cartValue.textColor = .black// #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        cartValue.backgroundColor = .white
        cartValue.layer.cornerRadius = 17
        cartValue.layer.masksToBounds = true
        cartValue.translatesAutoresizingMaskIntoConstraints = false
        cartValue.heightAnchor.constraint(equalTo: orderButton.heightAnchor, constant: 0).isActive = true
        cartValue.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        cartValue.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -8).isActive = true
        cartValue.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        orderButton.setTitle("Place Order", for: .normal)
        orderButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        orderButton.tintColor = .white
        orderButton.layer.cornerRadius = 17
        orderButton.titleLabel?.textAlignment = .center
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        orderButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        orderButton.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        cell.item = cartList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartListTable.reloadData()
        orderButton.isHidden = cartList.count == 0 ? true : false
    }
    
    @objc func placeOrder(){
        print("clciked place order")
    }
    
    func updateItems() {
        cartList = DataBaseQueries.getCartItems()
        delegate?.syncItems()
    }
    
    func syncItems() {
        cartList = DataBaseQueries.getCartItems()
    }
}
