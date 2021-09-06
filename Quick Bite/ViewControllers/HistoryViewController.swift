//
//  HistoryViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        historyList = DataBaseQueries.getHistory(session_id: DataBaseQueries.getSessionID())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var historyList = [OrderList]() {
        didSet{
            historyListTable.reloadData()
        }
    }
    
    var historyListTable = UITableView()
    var historyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
    }
    
    func setViews(){
        
        view.addSubview(historyLabel)
        view.addSubview(historyListTable)
    }
    
    func setConstraints(){
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        historyLabel.text = "History"
        historyLabel.numberOfLines = 0
        historyLabel.font = .boldSystemFont(ofSize: 22)
        historyLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        historyLabel.adjustsFontForContentSizeCategory = true
        historyLabel.textAlignment = .left
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        historyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        historyLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        historyListTable.delegate = self
        historyListTable.dataSource = self
        historyListTable.allowsSelection = true
        historyListTable.isUserInteractionEnabled = true
        historyListTable.separatorStyle = .none
        historyListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        historyListTable.translatesAutoresizingMaskIntoConstraints = false
        historyListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        historyListTable.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 8).isActive = true
        historyListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        historyListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        historyListTable.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
        cell.orderList = historyList[historyList.count - indexPath.row - 1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailsVC = OrderDetailsViewController()
        orderDetailsVC.ordersList = historyList[historyList.count - indexPath.row - 1]
        self.navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}
