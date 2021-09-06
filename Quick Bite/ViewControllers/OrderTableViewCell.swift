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
            symbol.image = item.isVeg == true ? UIImage(named: "Veg") : UIImage(named: "NonVeg")
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .full
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800)
            let date = dateFormatter.date(from: order.order_date)
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            let difference = Date().timeIntervalSince(date!)
            itemStatus.image = difference >= 60 ? UIImage(named: "Served") : UIImage(named: "Cooking")
        }
    }
    
    var itemLabel = UILabel()
    var symbol = UIImageView()
    let itemStatus = UIImageView()
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
        contentView.addSubview(itemStatus)
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
        symbol.rightAnchor.constraint(equalTo: itemStatus.leftAnchor, constant: -20).isActive = true
        
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
        totalPrice.rightAnchor.constraint(equalTo: itemStatus.leftAnchor, constant: -20).isActive = true
        
        itemStatus.contentMode = .scaleAspectFit
        itemStatus.translatesAutoresizingMaskIntoConstraints = false
        itemStatus.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        itemStatus.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20).isActive = true
        itemStatus.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20).isActive = true
        itemStatus.widthAnchor.constraint(equalTo: itemStatus.heightAnchor, constant: 0).isActive = true
    }
}
