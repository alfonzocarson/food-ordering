//
//  CartTableViewCell.swift
//  Quick Bite
//
//  Created by Mohammad on 12/08/21.
//

import UIKit

class CartTableViewCell: MenuTableViewCell {
    
    var totalPriceLabel = UILabel()
    var totalStack = UIStackView()
    
    override var item: Item! {
        didSet  {
            totalPriceLabel.text = "₹ \(item.price * item.qty)"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        reSetViews()
        reSetConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reSetViews(){
        super.qtyView.removeFromSuperview()
        totalStack.addArrangedSubview(super.qtyView)
        totalStack.addArrangedSubview(totalPriceLabel)
        super.addSubview(totalStack)
    }
    
    func reSetConstraints(){
        
        totalPriceLabel.font = .systemFont(ofSize: 16)
        totalPriceLabel.text = "₹ "
        totalPriceLabel.textAlignment = .center
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.widthAnchor.constraint(equalTo: totalStack.widthAnchor, constant: 0).isActive = true
        
        super.qtyView.widthAnchor.constraint(equalTo: totalStack.widthAnchor, constant: 0).isActive = true
        
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        totalStack.axis = .vertical
        totalStack.distribution = .equalSpacing
        totalStack.alignment = .center
        totalStack.topAnchor.constraint(equalTo: super.cardView.topAnchor, constant: 16).isActive = true
        totalStack.bottomAnchor.constraint(equalTo: super.cardView.bottomAnchor, constant: -16).isActive = true
        totalStack.rightAnchor.constraint(equalTo: super.cardView.rightAnchor, constant: -16).isActive = true
        totalStack.widthAnchor.constraint(equalTo: super.add.widthAnchor, constant: 0).isActive = true
        
    }
    
    @objc override func insertToCart(){
        plusTaped()
    }
    
    @objc override func minusTaped(){
        if item.qty>=1 {
            item.qty -= 1
            totalPriceLabel.text = "₹ \(item.price * item.qty)"
            DataBaseQueries.setQuantity(item_id: item.item_id, qty: item.qty)
            delegate?.updateItems()
        }
    }
    
    @objc override func plusTaped(){
        if item.qty<50 {
            item.qty += 1
            totalPriceLabel.text = "₹ \(item.price * item.qty)"
            DataBaseQueries.setQuantity(item_id: item.item_id, qty: item.qty)
            delegate?.updateItems()
        }
    }

}
