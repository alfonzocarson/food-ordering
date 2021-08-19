//
//  OrdersViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SyncItems {
    
    var menuList = [Item]()
    
    var ordersList: OrderList! {
        didSet {
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
        
        ordersLabel.text = "Orders 📄"
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
        //ordersListTable.allowsSelection = false
        //ordersListTable.isUserInteractionEnabled = true
        ordersListTable.separatorStyle = .none
        ordersListTable.isUserInteractionEnabled = true
        ordersListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        ordersListTable.translatesAutoresizingMaskIntoConstraints = false
        ordersListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        ordersListTable.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor, constant: 16).isActive = true
        ordersListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        ordersListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        ordersListTable.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
        cell.orderList = ordersList.orders[ordersList.orders.count - indexPath.row - 1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetails = OrderDetailsViewController()
        orderDetails.orderList = ordersList.orders[ordersList.orders.count - indexPath.row - 1]
        self.navigationController?.pushViewController(orderDetails, animated: true)
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
