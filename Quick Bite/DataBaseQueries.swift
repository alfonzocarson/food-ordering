//
//  DataBaseQueries.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import Foundation
import SQLite3

var dbQueue: OpaquePointer!

var dbUrl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

class DataBaseQueries{
    
    static func getMenuItems()->[Item] {
        
        var itemsList = [Item]()
        let selectString = """
        SELECT * FROM items;
        """
        
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                let item = Item(
                    item_id: Int(sqlite3_column_int(selectStatement, 0)),
                    item_name: String(cString: sqlite3_column_text(selectStatement, 1)),
                    desc: String(cString: sqlite3_column_text(selectStatement, 2)),
                    price: Int(sqlite3_column_int(selectStatement, 3)),
                    veg: (Int(sqlite3_column_int(selectStatement, 4)) != 0),
                    qty: Int(sqlite3_column_int(selectStatement, 5)),
                    category_id: Int(sqlite3_column_int(selectStatement, 6)),
                    category_name: String(cString: sqlite3_column_text(selectStatement, 7))
                )
                itemsList.append(item)
            }
        }
        else {
            print("Select items statement is not prepared.")
        }
        
        sqlite3_finalize(selectStatement)
        return itemsList
    }
    
    static func getCartItems()->[Item] {
        
        var cartList = [Item]()
        let selectString = """
        SELECT * FROM items WHERE qty > 0;
        """
        
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                let item: Item = Item(
                    item_id: Int(sqlite3_column_int(selectStatement, 0)),
                    item_name: String(cString: sqlite3_column_text(selectStatement, 1)),
                    desc: String(cString: sqlite3_column_text(selectStatement, 2)),
                    price: Int(sqlite3_column_int(selectStatement, 3)),
                    veg: (Int(sqlite3_column_int(selectStatement, 4)) != 0),
                    qty: Int(sqlite3_column_int(selectStatement, 5)),
                    category_id: Int(sqlite3_column_int(selectStatement, 6)),
                    category_name: String(cString: sqlite3_column_text(selectStatement, 7))
                )
                cartList.append(item)
            }
        }
        else {
            print("Select items statement is not prepared.")
        }
        sqlite3_finalize(selectStatement)
        return cartList
    }
    
    static func setQuantity(item_id: Int, qty:Int){
        let updateString = """
        UPDATE items SET qty = ? WHERE item_id = ?;
        """
        
        var updateStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(dbQueue, updateString, -1, &updateStatement, nil) ==
            SQLITE_OK {
            
            sqlite3_bind_int(updateStatement, 1, Int32(qty))
            sqlite3_bind_int(updateStatement, 2, Int32(item_id))
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("item \(item_id) qty update")
            }
            else {
                print("item \(item_id) qty not updated.\(String(cString: sqlite3_errmsg(dbQueue)))")
            }
            sqlite3_reset(updateStatement)
        }
        else {
            print("UPDATE statement is not prepared.")
        }
        
        sqlite3_finalize(updateStatement)
    }
    
    static func getOrders(session_id :Int)->OrderList {
        var ordersList = OrderList()
        let selectString = """
        SELECT * FROM orderItems WHERE session_id = ? ORDER BY order_date DESC;
        """
        
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            sqlite3_bind_int(selectStatement, 1, Int32(session_id))
            
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                _ = Int(sqlite3_column_int(selectStatement, 0))
                let order_id = Int(sqlite3_column_int(selectStatement, 1))
                let order: Order = Order(
                    item_id: Int(sqlite3_column_int(selectStatement, 2)),
                    order_date: String(cString: sqlite3_column_text(selectStatement, 3)),
                    order_qty: Int(sqlite3_column_int(selectStatement, 4)),
                    order_price: Int(sqlite3_column_int(selectStatement, 5)))
                var orders = ordersList.orders[order_id]
                orders?.append(order)
                //ordersList.orders.updateValue(orders ?? [order], forKey: order_id)
                ordersList.orders[order_id, default: []].append(order)
            }
        }
        else {
            print("Select items statement is not prepared.")
        }
        sqlite3_finalize(selectStatement)
        return ordersList
    }
    
    static func getHistory(session_id: Int) -> [OrderList]{
        var historyList = [OrderList]()
        for session in 1..<session_id {
            historyList.append(DataBaseQueries.getOrders(session_id: session))
        }
        return historyList
    }
    
    static func placeOrder(cartList: [Item], session_id: Int, order_id: Int){
        for item in cartList {
            DataBaseQueries.setQuantity(item_id: item.item_id, qty: 0)
            let insertString = """
            INSERT INTO orderItems (session_id, order_id, item_id, order_date, order_qty, order_price) VALUES (?, ?, ?, ?, ?, ?);
            """
            
            var insertStatement: OpaquePointer?
            
            if sqlite3_prepare_v2(dbQueue, insertString, -1, &insertStatement, nil) ==
                SQLITE_OK {
                
                sqlite3_bind_int(insertStatement, 1, Int32(session_id))
                sqlite3_bind_int(insertStatement, 2, Int32(order_id))
                sqlite3_bind_int(insertStatement, 3, Int32(item.item_id))
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .long
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800)
                sqlite3_bind_text(insertStatement, 4, "\(dateFormatter.string(from: date))", -1, nil)
                
                sqlite3_bind_int(insertStatement, 5, Int32(item.qty))
                sqlite3_bind_int(insertStatement, 6, Int32(item.price))
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("item \(item.item_name) inserted")
                }
                else {
                    print("item \(item.item_name) not inserted.\(String(cString: sqlite3_errmsg(dbQueue)))")
                }
                sqlite3_reset(insertStatement)
            }
            else {
                print("INSERT statement is not prepared.")
            }
            
            sqlite3_finalize(insertStatement)
        }
    }
    
    static func getSessionID()->Int {
        var session_id = Int.max
        let selectString = """
        SELECT MAX(session_id) FROM orderItems;
        """
        
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                session_id = min(session_id, Int(sqlite3_column_int(selectStatement, 0)))
            }
        }
        else {
            print("Select max statement is not prepared.")
        }
        sqlite3_finalize(selectStatement)
        return session_id + 1
    }
    
    static func getOrderID(session_id: Int)->Int {
        var order_id = -1
        let selectString = """
        SELECT MAX(order_id) FROM orderItems where session_id = ?;
        """
        
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            sqlite3_bind_int(selectStatement, 1, Int32(session_id))
            
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                order_id = max(0, Int(sqlite3_column_int(selectStatement, 0)))
            }
        }
        else {
            print("Select max statement is not prepared.")
        }
        sqlite3_finalize(selectStatement)
        return order_id == 0 ? 0 : order_id + 1
    }
    
    static func getItem(item_id :Int) -> Item{
        var item: Item = Item(item_id: item_id, item_name: "No such item", desc: "", price: 0, veg: false, qty: 0, category_id: 0, category_name: "")
        let selectString = """
        SELECT * FROM items where item_id = ?;
        """
        
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            sqlite3_bind_int(selectStatement, 1, Int32(item_id))
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                item = Item(
                    item_id: Int(sqlite3_column_int(selectStatement, 0)),
                    item_name: String(cString: sqlite3_column_text(selectStatement, 1)),
                    desc: String(cString: sqlite3_column_text(selectStatement, 2)),
                    price: Int(sqlite3_column_int(selectStatement, 3)),
                    veg: (Int(sqlite3_column_int(selectStatement, 4)) != 0),
                    qty: Int(sqlite3_column_int(selectStatement, 5)),
                    category_id: Int(sqlite3_column_int(selectStatement, 6)),
                    category_name: String(cString: sqlite3_column_text(selectStatement, 7))
                )
                return item
            }
        }
        else {
            print("Select max statement is not prepared.")
        }
        sqlite3_finalize(selectStatement)
        return item
    }
    
    static func createAndOpenDB(){
        
        var db: OpaquePointer?
        
        let url = NSURL(fileURLWithPath: dbUrl)
        
        if let pathComponent = url.appendingPathComponent("QuickBite.sqlite"){
            
            let filePath = pathComponent.path
            
            if sqlite3_open(filePath, &db) == SQLITE_OK {
                
                print("Successfully opened DB at \(filePath)")
                dbQueue = db
            }
            else{
                print("Unsuccessful opening DB")
            }
        }
        else{
            print("File path not available")
        }
        dbQueue = db
    }
    
    static func closeDB(){
        if sqlite3_close(dbQueue) == SQLITE_OK {
            print("Closed DB")
        }
        else {
            print("NotClosed DB")
        }
    }
    
    static func creteTables(){
        var createTableString = """
        CREATE TABLE IF NOT EXISTS items(
        item_id INT PRIMARY KEY NOT NULL,
        item_name VARCHAR NOT NULL,
        desc VARCHAR,
        price INT NOT NULL,
        veg INT NOT NULL,
        qty INT NOT NULL,
        category_id INT NOT NULL,
        category_name VARCHAR NOT NULL);
        """
        
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(dbQueue, createTableString, -1, &createTableStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("items table created.")
            }
            else {
                print("items table is not created.")
            }
        }
        else {
            print("\nCREATE TABLE statement is not prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
        
        createTableString = """
        CREATE TABLE IF NOT EXISTS orderItems(
        session_id INT NOT NULL,
        order_id INT NOT NULL,
        item_id INT NOT NULL,
        order_date TIMESTAMP NOT NULL,
        order_qty INT NOT NULL,
        order_price INT NOT NULL,
        PRIMARY KEY (session_id, order_id, item_id));
        
        """
        
        if sqlite3_prepare_v2(dbQueue, createTableString, -1, &createTableStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("orderItems table created.")
            }
            else {
                print("orderItems table is not created.")
            }
        }
        else {
            print("\nCREATE TABLE statement is not prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    static func insertItems(){
        
        let items : [(Int, NSString, NSString, Int, Int, Int, Int, NSString)] = [
            (1, "Baby Corn Crispy", "Corn", 150, 1, 0, 1, "Starters"),
            (2, "Baby Corn Manchurian", "Corn", 150, 1, 0, 1, "Starters"),
            (3, "Gobi 65", "Gobi", 150, 1, 0, 1, "Starters"),
            (4, "Gobi Manchurian", "Gobi", 150, 1, 0, 1, "Starters"),
            (5, "Mushroom Manchurian", "Corn", 150, 1, 0, 1, "Starters"),
            (6, "Paneer 65", "Paneer", 150, 1, 0, 1, "Starters"),
            (7, "Paneer Manchurian", "Paneer", 150, 1, 0, 1, "Starters"),
            (8, "Paneer Tikka", "Paneer", 150, 1, 0, 1, "Starters"),
            (9, "Tangdi Kabab", "Chicken", 130, 0, 0, 1, "Starters"),
            (10, "Tandoori Kabab", "Chicken", 170, 0, 0, 1, "Starters"),
            (11, "Chicken 65", "Chicken", 190, 0, 0, 1, "Starters"),
            (12, "Chicken Drumstick", "Chicken", 190, 0, 0, 1, "Starters"),
            (13, "Chicken Lollypop", "Chicken", 180, 0, 0, 1, "Starters"),
            (14, "Chicken Majestick", "Chicken", 190, 0, 0, 1, "Starters"),
            (15, "Chicken Manchurian", "Chicken", 190, 0, 0, 1, "Starters"),
            (16, "Chilli Fish Dry", "Fish", 190, 0, 0, 1, "Starters"),
            (17, "Chilli Prawns Dry", "Prawns", 190, 0, 0, 1, "Starters"),
            (18, "Mixed Veg Curry", "Veg", 120, 1, 0, 2, "Main Course"),
            (19, "Aloo Gobi Masala", "Aloo Gobi", 140, 1, 0, 2, "Main Course"),
            (20, "Mushroom Masala", "Mushroom", 140, 1, 0, 2, "Main Course"),
            (21, "Palak Paneer", "Paneer", 140, 1, 0, 2, "Main Course"),
            (22, "Paneer Butter Masala", "Paneer", 140, 1, 0, 2, "Main Course"),
            (23, "Kaju Paneer", "Paneer", 150, 1, 0, 2, "Main Course"),
            (24, "Kadai Paneer", "Paneer", 180, 1, 0, 2, "Main Course"),
            (25, "Dal Fry", "Dal", 110, 1, 0, 2, "Main Course"),
            (26, "Dal Tadka", "Dal", 110, 1, 0, 2, "Main Course"),
            (27, "Dal Makhani", "Dal", 130, 1, 0, 2, "Main Course"),
            (28, "Egg Curry", "Egg", 100, 0, 0, 2, "Main Course"),
            (29, "Butter Chicken", "Chicken", 180, 0, 0, 2, "Main Course"),
            (30, "Shahi Chicken", "Chicken", 180, 0, 0, 2, "Main Course"),
            (31, "Kadai Chicken", "Chicken", 180, 0, 0, 2, "Main Course"),
            (32, "Hyderabadi Mutton", "Mutton", 199, 0, 0, 2, "Main Course"),
            (33, "Mutton Rogan Josh", "Mutton", 199, 0, 0, 2, "Main Course"),
            (34, "Apollo Fish", "Fish", 220, 0, 0, 2, "Main Course"),
            (35, "Chilli Fish Gravy", "Fish", 220, 0, 0, 2, "Main Course"),
            (36, "Mutton Fry", "Mutton", 250, 0, 0, 2, "Main Course"),
            (37, "Jeera Fried Rice", "Rice", 110, 1, 0, 2, "Main Course"),
            (38, "Veg Fried Rice", "Rice", 110, 1, 0, 2, "Main Course"),
            (39, "Schezwan Veg Fried Rice", "Rice", 120, 1, 0, 2, "Main Course"),
            (40, "Chicken Fried Rice", "Chicken", 130, 0, 0, 2, "Main Course"),
            (41, "Egg Fried Rice", "Egg", 120, 0, 0, 2, "Main Course"),
            (42, "Water", "Water Bottle 1L", 25, 1, 0, 3, "Beverages"),
            (43, "Coca Cola", "Coke 2L", 80, 1, 0, 3, "Beverages"),
            (44, "Sprite", "Sprite 2.25L", 90, 1, 0, 3, "Beverages"),
            (45, "Thums Up", "Thums Up", 25, 1, 0, 3, "Beverages")]
        
        let insertString = """
        INSERT INTO items (item_id, item_name, desc, price, veg, qty, category_id, category_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
        """
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(dbQueue, insertString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            for item in items {
                
                sqlite3_bind_int(insertStatement, 1, Int32(item.0))
                sqlite3_bind_text(insertStatement, 2, item.1.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, item.2.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 4, Int32(item.3))
                sqlite3_bind_int(insertStatement, 5, Int32(item.4))
                sqlite3_bind_int(insertStatement, 6, Int32(item.5))
                sqlite3_bind_int(insertStatement, 7, Int32(item.6))
                sqlite3_bind_text(insertStatement, 8, item.7.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("item \(item.1) inserted")
                }
                else {
                    print("item \(item.1) not inserted.")
                }
                sqlite3_reset(insertStatement)
            }
        }
        else {
            print("INSERT statement is not prepared.")
        }
        
        sqlite3_finalize(insertStatement)
    }
}
