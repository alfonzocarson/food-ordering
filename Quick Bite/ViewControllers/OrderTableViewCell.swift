//
//  OrderTableViewCell.swift
//  Quick Bite
//
//  Created by Mohammad on 16/08/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var order: Order!{
        didSet{
            let item = DataBaseQueries.getItem(item_id: order.item_id)
            itemLabel.text = "\(item.item_name)"
            priceLabel.text = "\(order.order_qty)  ×  ₹\(order.order_price)"
            totalPrice.text = "₹ \(order.order_qty * order.order_price)"
            symbol.image = item.veg == true ? UIImage(named: "Veg") : UIImage(named: "NonVeg")
        }
    }
    var itemLabel = UILabel()
    var symbol = UIImageView()
    let cardView = UIView()
    let priceLabel = UILabel()
    let totalPrice = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setViews(){
        contentView.addSubview(cardView)
        contentView.addSubview(itemLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(totalPrice)
        contentView.addSubview(symbol)
        
    }
    
    func setConstraints(){
        
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0 , alpha: 1.0)
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 7.0
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowOpacity = 0.8
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8).isActive = true
        cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8).isActive = true
        
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        symbol.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16).isActive = true
        
        itemLabel.font = .systemFont(ofSize: 16)
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        itemLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 24).isActive = true
        
        priceLabel.font = .systemFont(ofSize: 15)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 24).isActive = true
        
        totalPrice.font = .systemFont(ofSize: 16)
        totalPrice.translatesAutoresizingMaskIntoConstraints = false
        totalPrice.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        totalPrice.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16).isActive = true
    }
}
