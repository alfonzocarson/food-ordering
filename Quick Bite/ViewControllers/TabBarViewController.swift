//
//  TabBarViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit


class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setViews()
    }
    
    func setViews(){
        
        DataBaseQueries.createAndOpenDB()
        DataBaseQueries.creteTables()
        DataBaseQueries.insertItems()
        DataBaseQueries.fetchItems()
        
        var vc: [UIViewController] = []
        
        vc.append(MenuViewController())
        vc.append(CartViewController())
        vc.append(OrdersViewController())
        vc.append(HistoryViewController())
        vc.append(SettingsViewController())
        
        self.setViewControllers(vc, animated: true)
        
        let tabNames = ["Menu","Cart","Orders","History","Settings"]
        
        for i in 0..<tabNames.count {
            vc[i].tabBarItem = UITabBarItem(title: tabNames[i], image: UIImage(named: tabNames[i]), selectedImage: UIImage(named: tabNames[i]))
        }
        
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        
    }
}
