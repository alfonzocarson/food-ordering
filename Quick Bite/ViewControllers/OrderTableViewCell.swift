//
//  OrderTableViewCell.swift
//  Quick Bite
//
//  Created by Mohammad on 16/08/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var orderLabel = UILabel()
    var nextButton = UIButton()
    let cardView = UIView()
    
    var order: [Order]! {
        didSet {
            orderLabel.text = "\(order.count)"
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
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        orderLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 24).isActive = true
        orderLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        orderLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        orderLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        nextButton.setImage(UIImage(named: "Next"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        nextButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
    }
}
