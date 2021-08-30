//
//  TabBarViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit


@available(iOS 13.0, *)
class TabBarViewController: UITabBarController, SyncItems, DismissDelegate, ChangeCurrentVC {
    
    var vc: [UIViewController] = []
    
    let menuVC = MenuViewController()
    let cartVC = CartViewController()
    let ordersVC = OrdersViewController()
    let historyVC = HistoryViewController()
    let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    func setViews(){
        
        menuVC.delegateSync = self
        cartVC.delegateSync = self
        cartVC.delegateOrders = self
        cartVC.delegateChangeVC = self
        ordersVC.dismissDelegate = self
        
        vc.append(menuVC)
        vc.append(cartVC)
        vc.append(ordersVC)
        vc.append(UINavigationController(rootViewController: historyVC))
        vc.append(settingsVC)
        
        self.setViewControllers(vc, animated: true)
        
        let tabNames = ["Menu","Cart","Orders","History","Settings"]
        
        for i in 0..<tabNames.count {
            vc[i].tabBarItem.badgeColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
            vc[i].tabBarItem = UITabBarItem(title: tabNames[i], image: UIImage(named: tabNames[i]), selectedImage: UIImage(named: tabNames[i]))
        }
        
        menuVC.menuList = DataBaseQueries.getMenuItems()
        cartVC.cartList = DataBaseQueries.getCartItems()
        cartVC.session_id = DataBaseQueries.getSessionID()
        cartVC.order_id = DataBaseQueries.getOrderID(session_id: cartVC.session_id)
        ordersVC.session_id = cartVC.session_id
        ordersVC.ordersList = DataBaseQueries.getOrders(session_id: cartVC.session_id)
        historyVC.historyList = DataBaseQueries.getHistory(session_id: cartVC.session_id)
        
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .red // #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
    }
    
    func syncItems() {
        menuVC.menuList = DataBaseQueries.getMenuItems()
        cartVC.cartList = DataBaseQueries.getCartItems()
        ordersVC.ordersList = DataBaseQueries.getOrders(session_id: cartVC.session_id)
    }
    
    func changeToOrdersVC(){
        self.selectedViewController = ordersVC
    }
    
    func changeToMenuVC(){
        self.selectedViewController = menuVC
    }
    
    func didDismiss() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        menuVC.menuList = DataBaseQueries.getMenuItems()
        cartVC.cartList = DataBaseQueries.getCartItems()
        cartVC.session_id = DataBaseQueries.getSessionID()
        cartVC.order_id = 0
        cartVC.order_id = DataBaseQueries.getOrderID(session_id: cartVC.session_id)
        ordersVC.session_id = cartVC.session_id
        ordersVC.ordersList = DataBaseQueries.getOrders(session_id: cartVC.session_id)
    }
}
