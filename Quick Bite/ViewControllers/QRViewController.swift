//
//  QRViewController.swift
//  Quick Bite
//
//  Created by Mohammad on 07/08/21.
//

import UIKit
import AVFoundation

@available(iOS 13.0, *)
class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    let squareView = UIImageView()
    let session = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
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
    }
    
    func setConstraints(){
        
        view.backgroundColor = #colorLiteral(red: 0.9183054566, green: 0.3281622529, blue: 0.3314601779, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        
        squareView.layer.borderWidth = 2
        squareView.layer.borderColor = UIColor.red.cgColor
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        squareView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor).isActive = true
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else{
                return
            }
            squareView.layer.borderColor = UIColor.green.cgColor
            print("readable object: \(readableObject.stringValue!)")

            session.stopRunning()

            let tabBarVC = TabBarViewController()
            tabBarVC.modalPresentationStyle = .fullScreen
            navigationController?.present(tabBarVC, animated: true, completion: nil)
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        session.stopRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        squareView.layer.borderColor = UIColor.red.cgColor
        session.startRunning()
    }
}
