//
//  HistoryTableViewCell.swift
//  
//
//  Created by Alfonzo on 30/08/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell{
    
    var orderList : OrderList!{
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .long
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800)
            let date = dateFormatter.date(from: orderList.orders[0]![0].order_date)
            dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            timeLabel.text = "\(dateFormatter.string(from: date!))"
            ordersCountLabel.text = "Orders: \(orderList.orders.count)"
            var amount = 0
            for (_, order) in orderList.orders {
                for item in order {
                    amount += item.order_qty * item.order_price
                }
            }
            orderAmountLabel.text = "₹ \(Double(amount) + Double(amount) * 0.05)"
        }
    }
    
    let cardView = UIView()
    let restaurantTitle = UILabel()
    let timeLabel = UILabel()
    let ordersCountLabel = UILabel()
    let orderAmountLabel = UILabel()
    
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
        contentView.addSubview(restaurantTitle)
        contentView.addSubview(timeLabel)
        contentView.addSubview(ordersCountLabel)
        contentView.addSubview(orderAmountLabel)
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
        
        restaurantTitle.text = "Random Restaurant"
        restaurantTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        restaurantTitle.translatesAutoresizingMaskIntoConstraints = false
        restaurantTitle.leftAnchor.constraint(equalTo: cardView.leftAnchor,constant: 24).isActive = true
        restaurantTitle.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textColor = .systemGray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor,constant: 24).isActive = true
        timeLabel.topAnchor.constraint(equalTo: restaurantTitle.bottomAnchor, constant: 8).isActive = true
        
        ordersCountLabel.font = .systemFont(ofSize: 15)
        ordersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersCountLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor,constant: 24).isActive = true
        ordersCountLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        
        orderAmountLabel.font = .systemFont(ofSize: 15)
        orderAmountLabel.textAlignment = .right
        orderAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        orderAmountLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor ,constant: -24).isActive = true
        orderAmountLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
    }
}
