//
//  OrderTableViewCell.swift
//  Quick Bite
//
//  Created by Mohammad on 16/08/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var orderLabel = UILabel()
    var orderAmount = UILabel()
    var nextButton = UIButton()
    let cardView = UIView()
    
    var orderList: [Order]! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .full
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800)
            let date = dateFormatter.date(from: orderList[0].order_date)
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            orderLabel.text = "Order placed at \(dateFormatter.string(from: date!))"
            var amount = 0
            for order in orderList {
                amount += order.order_qty * order.order_price
            }
            orderAmount.text = "Items: \(orderList.count)\nOrder Total: ₹ \(amount)"
        }
    }

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
        contentView.addSubview(orderLabel)
        contentView.addSubview(orderAmount)
        contentView.addSubview(nextButton)
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
        
        orderLabel.text = "Hi"
        orderLabel.font = .systemFont(ofSize: 15)
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        orderLabel.numberOfLines = 0
        orderLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 24).isActive = true
        orderLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        orderLabel.rightAnchor.constraint(equalTo: nextButton.rightAnchor, constant: -8).isActive = true
        
        orderAmount.text = "Hi"
        orderAmount.font = .systemFont(ofSize: 16)
        orderAmount.translatesAutoresizingMaskIntoConstraints = false
        orderAmount.numberOfLines = 0
        orderAmount.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 24).isActive = true
        orderAmount.rightAnchor.constraint(equalTo: nextButton.rightAnchor, constant: -8).isActive = true
        orderAmount.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        
        nextButton.setImage(UIImage(named: "Next"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        nextButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
    }
}
