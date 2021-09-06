//
//  QRViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit
import AVFoundation

@available(iOS 13.0, *)
class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let squareView = UIImageView()
    let session = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    let bottomCardView = UIView()
    
    let historyButton = UIButton()
    let settingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch{
            print("Error! Unable to initialize back camera: \(error.localizedDescription)")
        }

        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        squareView.layer.addSublayer(previewLayer)

        self.view.bringSubviewToFront(squareView)

        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
        DispatchQueue.main.async {
            self.previewLayer.frame = self.squareView.layer.bounds.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
    }
    
    func setViews(){
        view.addSubview(squareView)
        view.addSubview(bottomCardView)
        view.addSubview(historyButton)
        view.addSubview(settingsButton)
    }
    
    func setConstraints(){
        
        view.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        squareView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor).isActive = true
        
        bottomCardView.backgroundColor = UIColor(red: 240/250.0, green: 240/250.0, blue: 240/250.0, alpha: 1.0)
        bottomCardView.layer.cornerRadius = 15.0
        bottomCardView.layer.masksToBounds = false
        bottomCardView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        bottomCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottomCardView.layer.shadowOpacity = 0.8
        bottomCardView.translatesAutoresizingMaskIntoConstraints = false
        bottomCardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        bottomCardView.widthAnchor.constraint(equalTo: squareView.widthAnchor, multiplier: 1).isActive = true
        bottomCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        bottomCardView.heightAnchor.constraint(equalTo: squareView.widthAnchor, multiplier: 0.25).isActive = true
        
        historyButton.setTitle("History", for: .normal)
        historyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        historyButton.setTitleColor(.white, for: .normal)
        historyButton.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        historyButton.tintColor = .white
        historyButton.layer.cornerRadius = 15
        historyButton.tag = 1
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.centerYAnchor.constraint(equalTo: bottomCardView.centerYAnchor, constant: -4).isActive = true
        historyButton.widthAnchor.constraint(equalTo: bottomCardView.widthAnchor, multiplier: 0.25).isActive = true
        historyButton.centerXAnchor.constraint(equalTo: bottomCardView.centerXAnchor, constant: -75).isActive = true
        historyButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        settingsButton.tintColor = .white
        settingsButton.layer.cornerRadius = 15
        settingsButton.tag = 2
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.centerYAnchor.constraint(equalTo: bottomCardView.centerYAnchor, constant: -4).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: bottomCardView.widthAnchor, multiplier: 0.25).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: bottomCardView.centerXAnchor, constant: 75).isActive = true
        settingsButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else{
                return
            }
            
            print("readable object: \(readableObject.stringValue!)")

            session.stopRunning()

            let tabBarVC = TabBarViewController()
            tabBarVC.modalPresentationStyle = .fullScreen
            navigationController?.present(tabBarVC, animated: true, completion: nil)
        }
    }
    
    @objc func buttonClicked(sender: UIButton){
        if sender.tag == 1 {
            self.navigationController?.pushViewController(HistoryViewController(), animated: true)
        }
        else if sender.tag == 2 {
            self.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        session.stopRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        session.startRunning()
    }
}
