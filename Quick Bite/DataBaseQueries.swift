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
    
    static var itemsList : [(item_id: Int, item_name:String, desc: String, price:Int, veg:Int, qty:Int, category_id:Int, category_name:String)] = []
    static var filteredItems = itemsList
    static var cartItems : [(item_id: Int, item_name:String, desc: String, price:Int, veg:Int, qty:Int, category_id:Int, category_name:String)] = []
    
    static func fetchItems(){
        itemsList = []
        let selectString = """
        SELECT * FROM items;
        """
        var selectStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, selectString, -1, &selectStatement, nil) ==
            SQLITE_OK {
            
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                let item:(Int, String, String, Int, Int, Int, Int, String) = (
                    Int(sqlite3_column_int(selectStatement, 0)),
                    String(cString: sqlite3_column_text(selectStatement, 1)),
                    String(cString: sqlite3_column_text(selectStatement, 2)),
                    Int(sqlite3_column_int(selectStatement, 3)),
                    Int(sqlite3_column_int(selectStatement, 4)),
                    Int(sqlite3_column_int(selectStatement, 5)),
                    Int(sqlite3_column_int(selectStatement, 6)),
                    String(cString: sqlite3_column_text(selectStatement, 7))
                )
                itemsList.append(item)
            }
        }
        else {
            print("Select items statement is not prepared.")
        }
        
        sqlite3_finalize(selectStatement)
        filteredItems = []
        filteredItems = itemsList
        cartItems = []
        for item in filteredItems{
            if item.qty>0 {
                cartItems.append(item)
            }
        }
        
        print(cartItems.count)
    }
    
    static func getItem(at index:Int) -> (item_id: Int, item_name:String, desc: String, price:Int, veg:Int, qty:Int, category_id:Int, category_name:String){
        return filteredItems[index]
    }
    
    static func getCartItem(at index:Int) -> (item_id: Int, item_name:String, desc: String, price:Int, veg:Int, qty:Int, category_id:Int, category_name:String){
        return cartItems[index]
    }
    
    static func searchItems(having: String){
        if having == "" {
            filteredItems = itemsList
        }
        else {
            filteredItems = []
            for item in itemsList {
                if item.item_name.lowercased().contains(having.lowercased()){
                    filteredItems.append(item)
                }
            }
        }
        
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
                print("item \(item_id) qty not updated.")
            }
            sqlite3_reset(updateStatement)
        }
        else {
            print("UPDATE statement is not prepared.")
        }
        
        sqlite3_finalize(updateStatement)
        
        fetchItems()
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
    
    static func creteTables(){
        let createTableString = """
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
    }
    
    static func numberOfItems()->Int{
        return filteredItems.count
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

