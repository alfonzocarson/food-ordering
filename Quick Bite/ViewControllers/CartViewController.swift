//
//  CartViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateItems {
    
    var cartList = [Item](){
        didSet{
            cartListTable.reloadData()
            self.tabBarItem.badgeValue = cartList.count > 0 ? String(cartList.count) : nil
            var cartTotal = 0
            for item in cartList {
                cartTotal += item.price * item.qty
            }
            orderButton.isHidden = cartList.count == 0 ? true : false
            cartListTable.isHidden = cartList.count == 0 ? true : false
            emptyCartView.isHidden = cartList.count == 0 ? false : true
        }
    }
    
    var session_id: Int = 0
    var order_id: Int = 0
    
    weak var delegateSync: SyncItems?
    weak var delegateOrders: SyncItems?
    weak var delegateChangeVC: ChangeCurrentVC?
    
    let menuButton = UIButton()
    let emptyCartView = UIView()
    let emptyCartImage = UIImageView()
    let emptyCartLabel = UILabel()
    let cartLabel = UILabel()
    let cartListTable = UITableView()
    let orderButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
    }
    
    func setViews(){
        
        view.addSubview(cartLabel)
        view.addSubview(cartListTable)
        view.addSubview(emptyCartView)
        view.addSubview(orderButton)
        
        emptyCartView.addSubview(emptyCartImage)
        emptyCartView.addSubview(emptyCartLabel)
        emptyCartView.addSubview(menuButton)
    }
    
    func setConstraints(){
        
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        cartLabel.text = "Cart"
        cartLabel.numberOfLines = 0
        cartLabel.font = .boldSystemFont(ofSize: 22)
        cartLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        cartLabel.adjustsFontForContentSizeCategory = true
        cartLabel.textAlignment = .left
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        cartLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        cartLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        cartLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        cartListTable.delegate = self
        cartListTable.dataSource = self
        cartListTable.allowsSelection = false
        cartListTable.isUserInteractionEnabled = true
        cartListTable.separatorStyle = .none
        cartListTable.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        cartListTable.translatesAutoresizingMaskIntoConstraints = false
        cartListTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        cartListTable.topAnchor.constraint(equalTo: cartLabel.bottomAnchor, constant: 8).isActive = true
        cartListTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        cartListTable.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -8).isActive = true
        cartListTable.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        
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
        orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        orderButton.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        
        emptyCartView.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        emptyCartView.layer.cornerRadius = 7.0
        emptyCartView.layer.masksToBounds = false
        emptyCartView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        emptyCartView.layer.shadowOffset = CGSize(width: 0, height: 0)
        emptyCartView.layer.shadowOpacity = 0.8
        emptyCartView.translatesAutoresizingMaskIntoConstraints = false
        emptyCartView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        emptyCartView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        emptyCartView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -48).isActive = true
        emptyCartView.heightAnchor.constraint(equalTo: emptyCartView.widthAnchor, multiplier: 0.5).isActive = true
        
        emptyCartImage.contentMode = .scaleAspectFit
        emptyCartImage.translatesAutoresizingMaskIntoConstraints = false
        emptyCartImage.image = UIImage(named: "EmptyCart")
        emptyCartImage.leftAnchor.constraint(equalTo: emptyCartView.leftAnchor, constant: 16).isActive = true
        emptyCartImage.centerYAnchor.constraint(equalTo: emptyCartView.centerYAnchor, constant: 0).isActive = true
        emptyCartImage.widthAnchor.constraint(equalTo: emptyCartView.widthAnchor, multiplier: 0.2).isActive = true
        
        emptyCartLabel.sizeToFit()
        emptyCartLabel.numberOfLines = 0
        emptyCartLabel.text = "Your cart is empty.\nAdd something from the menu."
        emptyCartLabel.textAlignment = .center
        emptyCartLabel.font = .systemFont(ofSize: 15)
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyCartLabel.leftAnchor.constraint(equalTo: emptyCartImage.rightAnchor, constant: 16).isActive = true
        emptyCartLabel.rightAnchor.constraint(equalTo: emptyCartView.rightAnchor, constant: -16).isActive = true
        emptyCartLabel.bottomAnchor.constraint(equalTo: emptyCartView.centerYAnchor, constant: -8).isActive = true
        
        menuButton.sizeToFit()
        menuButton.setTitle("   Menu   ", for: .normal)
        menuButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        menuButton.tintColor = .white
        menuButton.layer.cornerRadius = 15
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.centerXAnchor.constraint(equalTo: emptyCartLabel.centerXAnchor).isActive = true
        menuButton.topAnchor.constraint(equalTo: emptyCartView.centerYAnchor, constant: 8).isActive = true
        menuButton.addTarget(self, action: #selector(menuButtonTap), for: .touchUpInside)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                       title: "    Delete    ") { [weak self] (action, view, completionHandler) in
                                        self?.removeItem(indexPath: indexPath)
                                        completionHandler(true)
        }
        delete.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartListTable.reloadData()
        orderButton.isHidden = cartList.count == 0 ? true : false
    }
    
    func removeItem(indexPath: IndexPath){
        DataBaseQueries.setQuantity(item_id: cartList[indexPath.row].item_id, qty: 0)
        updateItems()
    }
    
    @objc func placeOrder(){
        DataBaseQueries.placeOrder(cartList: cartList, session_id: session_id, order_id: order_id)
        order_id += 1
        updateItems()
        delegateChangeVC?.changeToOrdersVC()
    }
    
    @objc func menuButtonTap(){
        delegateChangeVC?.changeToMenuVC()
    }
    
    func updateItems() {
        delegateSync?.syncItems()
    }
}
