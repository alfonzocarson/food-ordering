//
//  OrderTableViewCell.swift
//  Quick Bite
//
//  Created by Mohammad on 16/08/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var orderLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setViews(){
        addSubview(orderLabel)
    }
    
    func setConstraints(){
        orderLabel.text = "Hi"
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        orderLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        orderLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        orderLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        orderLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}
