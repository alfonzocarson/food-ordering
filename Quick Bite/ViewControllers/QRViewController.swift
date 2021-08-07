//
//  QRViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
//    let squareView = UIImageView()
//    let session = AVCaptureSession()
//    var previewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
//        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
//
//        do{
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//            session.addInput(input)
//        }
//        catch{
//            print("Error!")
//        }
//
//        let output = AVCaptureMetadataOutput()
//        session.addOutput(output)
//        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//
//        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.frame = view.layer.bounds
//        view.layer.addSublayer(previewLayer)
//
//        squareView.layer.borderWidth = 4
//        squareView.layer.borderColor = UIColor.brown.cgColor
//
//        self.view.bringSubviewToFront(squareView)
//
//        session.startRunning()
        
    }
    
    func setViews(){
        //view.addSubview(squareView)
    }
    
    func setConstraints(){
        
        view.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        navigationController?.present(tabBarVC, animated: true, completion: nil)
//        let homeVC = HomeViewController()
//        homeVC.modalPresentationStyle = .fullScreen
//        navigationController?.present(homeVC, animated: true, completion: nil)
//        squareView.translatesAutoresizingMaskIntoConstraints = false
//        squareView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32).isActive = true
//        squareView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32).isActive = true
//        squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor).isActive = true
//        squareView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        if let metadataObject = metadataObjects.first {
//            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else{
//                return
//            }
//
//            print("readable object:\(readableObject.stringValue! )")
//            session.stopRunning()
//        }
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        session.stopRunning()
//    }
//
}
