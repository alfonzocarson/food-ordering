//
//  OrderDetailsViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 30/08/21.
//

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ordersList: OrderList!
    
    let detailsTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
    }
    
    func setViews(){
        
        view.addSubview(detailsTable)
    }
    
    func setConstraints(){
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        detailsTable.delegate = self
        detailsTable.dataSource = self
        detailsTable.allowsSelection = false
        detailsTable.isUserInteractionEnabled = true
        detailsTable.separatorStyle = .none
        detailsTable.isUserInteractionEnabled = true
        detailsTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        detailsTable.translatesAutoresizingMaskIntoConstraints = false
        detailsTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        detailsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        detailsTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        detailsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        detailsTable.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        detailsTable.register(OrdersSectionHeader.self, forHeaderFooterViewReuseIdentifier: "OrdersSectionHeader")
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
}
