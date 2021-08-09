//
//  CartViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cartLabel = UILabel()
    let cartListTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViews()
        setConstraints()
    }
    
    func setViews(){
        view.addSubview(cartLabel)
        view.addSubview(cartListTable)
    }
    
    func setConstraints(){
        title = "Cart"
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        cartLabel.text = "Cart"
        cartLabel.numberOfLines = 0
        cartLabel.font = .boldSystemFont(ofSize: 24)
        cartLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        cartLabel.adjustsFontForContentSizeCategory = true
        cartLabel.textAlignment = .center
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
        cartListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        cartListTable.register(ItemListTableViewCell.self, forCellReuseIdentifier: "ItemListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBaseQueries.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListTableViewCell") as! ItemListTableViewCell
        cell.item = DataBaseQueries.getCartItem(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartListTable.reloadData()
        print(DataBaseQueries.cartItems)
    }
}
