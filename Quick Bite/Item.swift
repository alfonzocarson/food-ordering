//
//  Item.swift
//  Quick Bite
//
//  Created by Mohammad on 11/08/21.
//

import Foundation

struct Item {
    var item_id: Int
    var item_name: String
    var desc: String
    var price: Int
    var veg: Bool
    var qty: Int
    var category_id: Int
    var category_name: String
}

struct Order {
    var item_id: Int
    var order_date: String
    var order_qty: Int
    var order_price: Int
}

struct OrderList {
    var orders = [Int:[Order]]()
}

protocol UpdateItems: AnyObject {
    func updateItems()
}

protocol SyncItems: AnyObject {
    func syncItems()
}

protocol DismissDelegate: AnyObject {
    func didDismiss()
}

protocol ChangeCurrentVC: AnyObject {
    func changeToOrdersVC()
    func changeToMenuVC()
}
