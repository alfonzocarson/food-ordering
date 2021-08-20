//
//  SettingsViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    func setViews(){
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(imageView)
    }
    
    func setConstraints(){
        view.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        
        nameLabel.text = "A Random Name"
        nameLabel.numberOfLines = 0
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        emailLabel.text = "arandomemail@email.com"
        emailLabel.numberOfLines = 0
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        
        phoneLabel.text = "+91 8976453201"
        phoneLabel.numberOfLines = 0
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8).isActive = true
        
        imageView.backgroundColor = .lightGray
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        imageView.layer.cornerRadius = 32
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        imageView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: -64).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: 0).isActive = true
        
    }
    
}
