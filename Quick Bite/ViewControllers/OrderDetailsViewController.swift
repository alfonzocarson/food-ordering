//
//  OrderDetailsViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 18/08/21.
//

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var orderList: [Order]!
    
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
        navigationItem.title = "Order Summary"
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
        detailsTable.register(OrderDetailTableViewCell.self, forCellReuseIdentifier: "OrderDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell") as! OrderDetailTableViewCell
        cell.order = orderList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
