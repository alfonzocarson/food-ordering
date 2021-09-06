//
//  MenuViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit
import SQLite3

@available(iOS 13.0, *)
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UpdateItems  {
    
    init()   {
        super.init(nibName: nil, bundle: nil)
        menuList = DataBaseQueries.getMenuItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var menuList = [Item](){
        didSet{
            filteredMenuList = menuList
            searchBar(searchBar, textDidChange: searchBar.text ?? "")
        }
    }
    
    var filteredMenuList = [Item](){
        didSet{
            menuListTable.reloadData()
        }
    }
    
    weak var delegateSync: SyncItems?
    
    let welcomeLabel = UILabel()
    let searchBar = UISearchBar()
    let menuListTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
    }
    
    func setViews(){
        
        view.addSubview(welcomeLabel)
        view.addSubview(menuListTable)
    }
    
    func setConstraints(){
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        welcomeLabel.text = "Random Restaurant"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.font = .boldSystemFont(ofSize: 22)
        welcomeLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.textAlignment = .left
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search here..."
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        searchBar.barTintColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        searchBar.layer.cornerRadius = 7.0
        searchBar.delegate = self
        
        menuListTable.delegate = self
        menuListTable.dataSource = self
        menuListTable.allowsSelection = false
        menuListTable.isUserInteractionEnabled = true
        menuListTable.separatorStyle = .none
        menuListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        menuListTable.translatesAutoresizingMaskIntoConstraints = false
        menuListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        menuListTable.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8).isActive = true
        menuListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        menuListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        menuListTable.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        menuListTable.tableHeaderView = searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.item = filteredMenuList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchString = searchText.lowercased()
        if(searchString == "") {
            filteredMenuList = menuList
        }
        else{
            filteredMenuList = []
            for item in menuList {
                if item.item_name.lowercased().contains(searchString) {
                    filteredMenuList.append(item)
                }
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        filteredMenuList = menuList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuListTable.reloadData()
    }
    
    func updateItems() {
        delegateSync?.syncItems()
    }
}
