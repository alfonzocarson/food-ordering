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
    let userImageView = UIImageView()
    
    let generalLabel = UILabel()
    let generalStackView = UIStackView()
    let generalView = UIView()
    
    let profileStackView = UIStackView()
    let profileIcon = UIImageView()
    let profileLabel = UILabel()
    
    let notificationStackView = UIStackView()
    let notificationIcon = UIImageView()
    let notificationLabel = UILabel()
    
    let paymentStackView = UIStackView()
    let paymentIcon = UIImageView()
    let paymentLabel = UILabel()
    
    let preferenceStackView = UIStackView()
    let preferenceIcon = UIImageView()
    let preferenceLabel = UILabel()
    
    let securityStackView = UIStackView()
    let securityIcon = UIImageView()
    let securityLabel = UILabel()
    
    let otherLabel = UILabel()
    let otherStackView = UIStackView()
    let otherView = UIView()
    
    let termsStackView = UIStackView()
    let termsIcon = UIImageView()
    let termsLabel = UILabel()
    
    let privacyStackView = UIStackView()
    let privacyIcon = UIImageView()
    let privacyLabel = UILabel()
    
    let supportStackView = UIStackView()
    let supportIcon = UIImageView()
    let supportLabel = UILabel()
    
    let rateStackView = UIStackView()
    let rateIcon = UIImageView()
    let rateLabel = UILabel()
    
    let feedbackStackView = UIStackView()
    let feedbackIcon = UIImageView()
    let feedbackLabel = UILabel()
    
    let bugStackView = UIStackView()
    let bugIcon = UIImageView()
    let bugLabel = UILabel()
    
    let aboutStackView = UIStackView()
    let aboutIcon = UIImageView()
    let aboutLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    func setViews(){
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(userImageView)
        view.addSubview(generalView)
        view.addSubview(generalLabel)
        view.addSubview(generalStackView)
        view.addSubview(otherView)
        view.addSubview(otherLabel)
        view.addSubview(otherStackView)
        
        generalStackView.addArrangedSubview(profileStackView)
        generalStackView.addArrangedSubview(notificationStackView)
        generalStackView.addArrangedSubview(paymentStackView)
        generalStackView.addArrangedSubview(preferenceStackView)
        generalStackView.addArrangedSubview(securityStackView)
        
        profileStackView.addArrangedSubview(profileIcon)
        profileStackView.addArrangedSubview(profileLabel)
        
        notificationStackView.addArrangedSubview(notificationIcon)
        notificationStackView.addArrangedSubview(notificationLabel)
        
        paymentStackView.addArrangedSubview(paymentIcon)
        paymentStackView.addArrangedSubview(paymentLabel)
        
        preferenceStackView.addArrangedSubview(preferenceIcon)
        preferenceStackView.addArrangedSubview(preferenceLabel)
        
        securityStackView.addArrangedSubview(securityIcon)
        securityStackView.addArrangedSubview(securityLabel)
        
        otherStackView.addArrangedSubview(termsStackView)
        otherStackView.addArrangedSubview(privacyStackView)
        otherStackView.addArrangedSubview(supportStackView)
        otherStackView.addArrangedSubview(rateStackView)
        otherStackView.addArrangedSubview(feedbackStackView)
        otherStackView.addArrangedSubview(bugStackView)
        otherStackView.addArrangedSubview(aboutStackView)
        
        termsStackView.addArrangedSubview(termsIcon)
        termsStackView.addArrangedSubview(termsLabel)
        
        privacyStackView.addArrangedSubview(privacyIcon)
        privacyStackView.addArrangedSubview(privacyLabel)
        
        supportStackView.addArrangedSubview(supportIcon)
        supportStackView.addArrangedSubview(supportLabel)
        
        rateStackView.addArrangedSubview(rateIcon)
        rateStackView.addArrangedSubview(rateLabel)
        
        bugStackView.addArrangedSubview(bugIcon)
        bugStackView.addArrangedSubview(bugLabel)
        
        feedbackStackView.addArrangedSubview(feedbackIcon)
        feedbackStackView.addArrangedSubview(feedbackLabel)
        
        aboutStackView.addArrangedSubview(aboutIcon)
        aboutStackView.addArrangedSubview(aboutLabel)
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
        
        userImageView.image = UIImage(named: "ProfilePhoto")
        userImageView.clipsToBounds = true
        userImageView.contentMode = .center
        userImageView.layer.borderWidth = 2
        userImageView.layer.borderColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        userImageView.layer.cornerRadius = 36
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        userImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor, constant: 0).isActive = true
        userImageView.bottomAnchor.constraint(equalTo: generalLabel.topAnchor, constant: -16).isActive = true
        
        generalView.layer.cornerRadius = 7.0
        generalView.layer.masksToBounds = false
        generalView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        generalView.layer.shadowOffset = CGSize(width: 0, height: 0)
        generalView.layer.shadowOpacity = 0.8
        generalView.backgroundColor = .white
        generalView.translatesAutoresizingMaskIntoConstraints = false
        generalView.leftAnchor.constraint(equalTo: generalStackView.leftAnchor).isActive = true
        generalView.topAnchor.constraint(equalTo: generalStackView.topAnchor).isActive = true
        generalView.rightAnchor.constraint(equalTo: generalStackView.rightAnchor).isActive = true
        generalView.bottomAnchor.constraint(equalTo: generalStackView.bottomAnchor).isActive = true
        
        generalLabel.text = "General"
        generalLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        generalLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        generalLabel.textAlignment = .left
        generalLabel.sizeToFit()
        generalLabel.translatesAutoresizingMaskIntoConstraints = false
        generalLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        generalLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 16).isActive = true
        generalLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        generalStackView.axis = .vertical
        generalStackView.distribution = .equalSpacing
        generalStackView.isLayoutMarginsRelativeArrangement = true
        generalStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        generalStackView.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 8).isActive = true
        generalStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        generalStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        profileStackView.axis = .horizontal
        profileStackView.distribution = .fillProportionally
        profileStackView.spacing = 16
        
        notificationStackView.axis = .horizontal
        notificationStackView.distribution = .fillProportionally
        notificationStackView.spacing = 16
        
        paymentStackView.axis = .horizontal
        paymentStackView.distribution = .fillProportionally
        paymentStackView.spacing = 16
        
        preferenceStackView.axis = .horizontal
        preferenceStackView.distribution = .fillProportionally
        preferenceStackView.spacing = 16
        
        securityStackView.axis = .horizontal
        securityStackView.distribution = .fillProportionally
        securityStackView.spacing = 16
        
        profileIcon.image = UIImage(named: "ProfilePhoto")
        profileIcon.contentMode = .scaleAspectFit
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        profileIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        profileIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        profileLabel.text = "Accounts & Profile"
        profileLabel.font = .systemFont(ofSize: 15)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notificationIcon.image = UIImage(named: "Bell")
        notificationIcon.contentMode = .scaleAspectFit
        notificationIcon.translatesAutoresizingMaskIntoConstraints = false
        notificationIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        notificationIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        notificationLabel.text = "Notifications"
        notificationLabel.font = .systemFont(ofSize: 15)
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        paymentIcon.image = UIImage(named: "CardPay")
        paymentIcon.contentMode = .scaleAspectFit
        paymentIcon.translatesAutoresizingMaskIntoConstraints = false
        paymentIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        paymentIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        paymentLabel.text = "Payment Methods"
        paymentLabel.font = .systemFont(ofSize: 15)
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        preferenceIcon.image = UIImage(named: "Preferences")
        preferenceIcon.contentMode = .scaleAspectFit
        preferenceIcon.translatesAutoresizingMaskIntoConstraints = false
        preferenceIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        preferenceIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        preferenceLabel.text = "Personalize"
        preferenceLabel.font = .systemFont(ofSize: 15)
        preferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        securityIcon.image = UIImage(named: "Security")
        securityIcon.contentMode = .scaleAspectFit
        securityIcon.translatesAutoresizingMaskIntoConstraints = false
        securityIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        securityIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        securityLabel.text = "Security and Privacy"
        securityLabel.font = .systemFont(ofSize: 15)
        securityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        
        otherView.layer.cornerRadius = 7.0
        otherView.layer.masksToBounds = false
        otherView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        otherView.layer.shadowOffset = CGSize(width: 0, height: 0)
        otherView.layer.shadowOpacity = 0.8
        otherView.backgroundColor = .white
        otherView.translatesAutoresizingMaskIntoConstraints = false
        otherView.leftAnchor.constraint(equalTo: otherStackView.leftAnchor).isActive = true
        otherView.topAnchor.constraint(equalTo: otherStackView.topAnchor).isActive = true
        otherView.rightAnchor.constraint(equalTo: otherStackView.rightAnchor).isActive = true
        otherView.bottomAnchor.constraint(equalTo: otherStackView.bottomAnchor).isActive = true
        
        otherLabel.text = "Others"
        otherLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        otherLabel.textColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        otherLabel.textAlignment = .left
        otherLabel.sizeToFit()
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        otherLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        otherLabel.topAnchor.constraint(equalTo: generalStackView.bottomAnchor, constant: 16).isActive = true
        otherLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        otherStackView.axis = .vertical
        otherStackView.distribution = .equalSpacing
        otherStackView.isLayoutMarginsRelativeArrangement = true
        otherStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        otherStackView.translatesAutoresizingMaskIntoConstraints = false
        otherStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        otherStackView.topAnchor.constraint(equalTo: otherLabel.bottomAnchor, constant: 8).isActive = true
        otherStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        otherStackView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        termsStackView.axis = .horizontal
        termsStackView.distribution = .fillProportionally
        termsStackView.spacing = 16
        
        privacyStackView.axis = .horizontal
        privacyStackView.distribution = .fillProportionally
        privacyStackView.spacing = 16
        
        supportStackView.axis = .horizontal
        supportStackView.distribution = .fillProportionally
        supportStackView.spacing = 16
        
        rateStackView.axis = .horizontal
        rateStackView.distribution = .fillProportionally
        rateStackView.spacing = 16
        
        bugStackView.axis = .horizontal
        bugStackView.distribution = .fillProportionally
        bugStackView.spacing = 16
        
        feedbackStackView.axis = .horizontal
        feedbackStackView.distribution = .fillProportionally
        feedbackStackView.spacing = 16
        
        aboutStackView.axis = .horizontal
        aboutStackView.distribution = .fillProportionally
        aboutStackView.spacing = 16
        
        termsIcon.image = UIImage(named: "Terms")
        termsIcon.contentMode = .scaleAspectFit
        termsIcon.translatesAutoresizingMaskIntoConstraints = false
        termsIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        termsIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        termsLabel.text = "Terms & Conditions"
        termsLabel.font = .systemFont(ofSize: 15)
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        privacyIcon.image = UIImage(named: "Lock")
        privacyIcon.contentMode = .scaleAspectFit
        privacyIcon.translatesAutoresizingMaskIntoConstraints = false
        privacyIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        privacyIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        privacyLabel.text = "Privacy Policy"
        privacyLabel.font = .systemFont(ofSize: 15)
        privacyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        supportIcon.image = UIImage(named: "Support")
        supportIcon.contentMode = .scaleAspectFit
        supportIcon.translatesAutoresizingMaskIntoConstraints = false
        supportIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        supportIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        supportLabel.text = "Help & Support"
        supportLabel.font = .systemFont(ofSize: 15)
        supportLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rateIcon.image = UIImage(named: "RateUs")
        rateIcon.contentMode = .scaleAspectFit
        rateIcon.translatesAutoresizingMaskIntoConstraints = false
        rateIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        rateIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        rateLabel.text = "Rate Us"
        rateLabel.font = .systemFont(ofSize: 15)
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        feedbackIcon.image = UIImage(named: "Feedback")
        feedbackIcon.contentMode = .scaleAspectFit
        feedbackIcon.translatesAutoresizingMaskIntoConstraints = false
        feedbackIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        feedbackIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        feedbackLabel.text = "Send Feedback"
        feedbackLabel.font = .systemFont(ofSize: 15)
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bugIcon.image = UIImage(named: "Bug")
        bugIcon.contentMode = .scaleAspectFit
        bugIcon.translatesAutoresizingMaskIntoConstraints = false
        bugIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        bugIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        bugLabel.text = "Report a Bug"
        bugLabel.font = .systemFont(ofSize: 15)
        bugLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aboutIcon.image = UIImage(named: "Info")
        aboutIcon.contentMode = .scaleAspectFit
        aboutIcon.translatesAutoresizingMaskIntoConstraints = false
        aboutIcon.widthAnchor.constraint(equalToConstant: 17.5).isActive = true
        aboutIcon.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        
        aboutLabel.text = "About Us"
        aboutLabel.font = .systemFont(ofSize: 15)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
