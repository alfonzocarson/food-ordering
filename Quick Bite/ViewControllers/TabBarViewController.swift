//
//  TabBarViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit


class TabBarViewController: UITabBarController {
    
    static var vc: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setViews()
    }
    
    func setViews(){
        
        TabBarViewController.vc.append(MenuViewController())
        TabBarViewController.vc.append(CartViewController())
        TabBarViewController.vc.append(OrdersViewController())
        TabBarViewController.vc.append(HistoryViewController())
        TabBarViewController.vc.append(SettingsViewController())
        
        self.setViewControllers(TabBarViewController.vc, animated: true)
        
        DataBaseQueries.createAndOpenDB()
        DataBaseQueries.creteTables()
        DataBaseQueries.insertItems()
        DataBaseQueries.fetchItems()
        
        let tabNames = ["Menu","Cart","Orders","History","Settings"]
        
        for i in 0..<tabNames.count {
            TabBarViewController.vc[i].tabBarItem = UITabBarItem(title: tabNames[i], image: UIImage(named: tabNames[i]), selectedImage: UIImage(named: tabNames[i]))
        }
        
        TabBarViewController.vc[1].tabBarItem.badgeColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        
        if DataBaseQueries.cartItems.count > 0{
            TabBarViewController.vc[1].tabBarItem.badgeValue = String(DataBaseQueries.cartItems.count)
        }
        
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        
    }
}
