//
//  ViewController.swift
//  Assi9
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let subView = UIView()
    
    private let imgview:UIImageView={
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(named: "wwdc")
        return img
    }()
    
    private let ImagePicker : UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = false
        return ip
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subView)
         subView.addSubview(imgview)
        ImagePicker.delegate = self
        subView.frame = CGRect(x: 30, y: 150, width:300, height: 300)
        imgview.frame = CGRect(x: 0, y: 0, width:200, height: 200)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        subView.addGestureRecognizer(tapGesture)
        
        let pinchGestuer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchView))
        view.addGestureRecognizer(pinchGestuer)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotateView))
        view.addGestureRecognizer(rotationGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        view.addGestureRecognizer(panGesture)
    }
   
}
extension ViewController {
    @objc private func didTapView(gesture: UITapGestureRecognizer){
        print("Tapped at Location :\(gesture.location(in: view))")
        ImagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.ImagePicker,animated: true)
        }
    }
    @objc private func didPinchView(gesture: UIPinchGestureRecognizer)
    {
       subView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func didRotateView(gesture : UIRotationGestureRecognizer)
     {
      subView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func didSwipeView(gesture : UISwipeGestureRecognizer)
    {
        if gesture.direction == .left{
            UIView.animate(withDuration : 0.5){
                self.subView.frame = CGRect(x: self.subView.frame.origin.x-40, y: self.subView.frame.origin.y, width: 200, height: 200)
            }
            
        }else if gesture.direction == .right {
            subView.frame = CGRect(x: subView.frame.origin.x+40, y: subView.frame.origin.y, width: 200, height: 200)
        }else if gesture.direction == .up {
            subView.frame = CGRect(x: subView.frame.origin.x, y: subView.frame.origin.y-40, width: 200, height: 200)
        }else if gesture.direction == .down{
            subView.frame = CGRect(x: subView.frame.origin.x, y: subView.frame.origin.y+40, width: 200, height: 200)
        }
    }
    
    @objc private func didPanView(gesture : UIPanGestureRecognizer)
    {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        
        subView.center = CGPoint(x: x,y: y)
    }
    
}

extension ViewController : UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            imgview.image = selectedImage
        }
        picker.dismiss(animated: true)
    }
}
