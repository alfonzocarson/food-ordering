//
//  HistoryViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuList = [Item]()
    
    var historyList = [Item]() {
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
        
        historyLabel.text = "History 📖"
        historyLabel.numberOfLines = 0
        historyLabel.font = .boldSystemFont(ofSize: 24)
        historyLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        historyLabel.adjustsFontForContentSizeCategory = true
        historyLabel.textAlignment = .center
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        historyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        historyLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
        
        return cell
    }
}

class HistoryTableViewCell: UITableViewCell{
    
}

