//
//  TabBarViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit


class TabBarViewController: UITabBarController {
    
    var vc: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setViews()
    }
    
    func setViews(){
        DataBaseQueries.createAndOpenDB()
        DataBaseQueries.creteTables()
        DataBaseQueries.insertItems()
        
        let menuVC = MenuViewController()
        let cartVC = CartViewController()
        let ordersVC = OrdersViewController()
        let historyVC = HistoryViewController()
        let settingsVC = SettingsViewController()
        
        menuVC.delegate = cartVC
        cartVC.delegate = menuVC
        
        vc.append(menuVC)
        vc.append(cartVC)
        vc.append(ordersVC)
        vc.append(historyVC)
        vc.append(settingsVC)
        
        self.setViewControllers(vc, animated: true)
        
        let tabNames = ["Menu","Cart","Orders","History","Settings"]
        
        for i in 0..<tabNames.count {
            vc[i].tabBarItem = UITabBarItem(title: tabNames[i], image: UIImage(named: tabNames[i]), selectedImage: UIImage(named: tabNames[i]))
        }
        
        vc[1].tabBarItem.badgeColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        menuVC.menuList = DataBaseQueries.getMenuItems()
        cartVC.cartList = DataBaseQueries.getCartItems()
        
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        
    }
}
