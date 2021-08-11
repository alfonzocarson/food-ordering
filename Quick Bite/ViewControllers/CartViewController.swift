//
//  CartViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var cartTotal = 0
    
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
        cartListTable.bottomAnchor.constraint(equalTo: cartValue.topAnchor, constant: -16).isActive = true
        cartListTable.register(ItemListTableViewCell.self, forCellReuseIdentifier: "ItemListTableViewCell")
        
        if CartViewController.cartTotal > 0 {
            cartValue.text = "Your Cart Value = ₹ \(CartViewController.cartTotal)"
        }
        else {
            cartValue.text = "Your Cart is Empty"
        }
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
        orderButton.isHidden = DataBaseQueries.cartItems.count == 0 ? true : false
        if CartViewController.cartTotal > 0 {
            cartValue.text = "Your Cart Value: ₹ \(CartViewController.cartTotal)"
        }
        else {
            cartValue.text = "Your Cart is Empty"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Add animations here
        cell.alpha = 0.7
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if CartViewController.cartTotal > 0 {
            cartValue.text = "Your Cart Value: ₹ \(CartViewController.cartTotal)"
        }
        else {
            cartValue.text = "Your Cart is Empty"
        }
        cartListTable.reloadData()
        orderButton.isHidden = DataBaseQueries.cartItems.count == 0 ? true : false
    }
    
    @objc func placeOrder(){
        if CartViewController.cartTotal > 0 {
            cartValue.text = "Your Cart Value: ₹ \(CartViewController.cartTotal)"
        }
        else {
            cartValue.text = "Your Cart is Empty"
        }
        cartListTable.reloadData()
    }
    
    func cartUpdated(_ value: Int){
        if value > 0 {
            cartValue.text = "Your Cart Value: ₹ \(value)"
        }
        else {
            cartValue.text = "Your Cart is Empty"
        }
        cartListTable.reloadData()
    }
}
