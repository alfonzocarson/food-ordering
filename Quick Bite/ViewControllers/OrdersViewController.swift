//
//  OrdersViewController.swift
//  Quick Bite
//w
//  Created by Mohammad on 07/08/21.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuList = [Item]()
    
    var ordersList = [Item]() {
        didSet{
            ordersListTable.reloadData()
        }
    }
    
    var ordersListTable = UITableView()
    var ordersLabel = UILabel()

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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
        
        return cell
    }
}

class OrderTableViewCell: UITableViewCell{
    
}
