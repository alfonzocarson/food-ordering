//
//  MenuTableViewCell.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    var item: Item! {
        didSet{
            priceLabel.text = "₹ \(item.price)"
            itemLabel.text = item.item_name
            symbol.image = item.veg == true ? UIImage(named: "Veg") : UIImage(named: "NonVeg")
            qty = item.qty
        }
    }
    
    weak var delegate: UpdateItems?
    
    let img = UIImageView()
    let symbol = UIImageView()
    let itemLabel = UILabel()
    let priceLabel = UILabel()
    let add = UIButton()
    let cardView = UIView()
    let stackView = UIStackView()
    
    let qtyView = UIStackView()
    let qtyLabel = UILabel()
    var qty = 0 {
        didSet {
            qtyLabel.text = "\(qty)"
            if qty <= 0 {
                add.isHidden = false
                qtyView.isHidden = true
            }
            else{
                add.isHidden = true
                qtyView.isHidden = false
            }
        }
    }
    let plusBtn = UIButton()
    let minusBtn = UIButton()
    
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
        contentView.addSubview(img)
        contentView.addSubview(stackView)
        contentView.addSubview(add)
        contentView.addSubview(qtyView)
        
        stackView.addArrangedSubview(symbol)
        stackView.addArrangedSubview(itemLabel)
        stackView.addArrangedSubview(priceLabel)
        
        qtyView.addArrangedSubview(minusBtn)
        qtyView.addArrangedSubview(qtyLabel)
        qtyView.addArrangedSubview(plusBtn)
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
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.leftAnchor.constraint(equalTo: cardView.leftAnchor,constant: 24).isActive = true
        stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        
        symbol.translatesAutoresizingMaskIntoConstraints = false
        
        itemLabel.font = .boldSystemFont(ofSize: 18)
        itemLabel.text = "Food Item"
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.text = "₹ "
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        add.setTitle("   ADD   ", for: .normal)
        add.titleLabel?.font = .boldSystemFont(ofSize: 16)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        add.tintColor = .white
        add.layer.cornerRadius = 15
        add.translatesAutoresizingMaskIntoConstraints = false
        add.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        add.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        add.addTarget(self, action: #selector(insertToCart), for: .touchUpInside)
        
        minusBtn.setImage(UIImage(named: "Minus"), for: .normal)
        minusBtn.contentMode = .scaleToFill
        minusBtn.translatesAutoresizingMaskIntoConstraints = false
        minusBtn.addTarget(self, action: #selector(minusTaped), for: .touchUpInside)
        
        qtyLabel.text = "\(qty)"
        qtyLabel.font = .systemFont(ofSize: 18)
        qtyLabel.textAlignment = .center
        qtyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        plusBtn.setImage(UIImage(named: "Plus"), for: .normal)
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.addTarget(self, action: #selector(plusTaped), for: .touchUpInside)
        
        qtyView.axis = .horizontal
        qtyView.distribution = .equalSpacing
        qtyView.alignment = .center
        qtyView.translatesAutoresizingMaskIntoConstraints = false
        qtyView.isUserInteractionEnabled = true
        qtyView.heightAnchor.constraint(equalTo: add.heightAnchor).isActive = true
        qtyView.widthAnchor.constraint(equalTo: add.widthAnchor, constant: 8).isActive = true
        qtyView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        qtyView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        qtyView.isHidden = true
    }
    
    @objc func insertToCart(){
        plusTaped()
    }
    
    @objc func minusTaped(){
        if item.qty>=1 {
            item.qty -= 1
            DataBaseQueries.setQuantity(item_id: item.item_id, qty: item.qty)
            delegate?.updateItems()
        }
    }
    
    @objc func plusTaped(){
        if item.qty<50 {
            item.qty += 1
            DataBaseQueries.setQuantity(item_id: item.item_id, qty: item.qty)
            delegate?.updateItems()
        }
    }
}
