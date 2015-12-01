//
//  CameraViewController.swift
//  Sample-GoogleMapsSDK
//
//  Created by Ronaldo GomesJr on 13/11/2015.
//  Copyright © 2015 TechnophileIT. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var photoCollectionView:UICollectionView!
    private var takePhotoButton:UIButton!
    private var choosePhotoButton:UIButton!
    
    private var showImageView:UIImageView!
    private var buttonsPanel:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.photoCollectionView = UICollectionView()
        //        self.photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //        self.view.addSubview(self.photoCollectionView)
        
        self.showImageView = UIImageView()
        self.showImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.showImageView)
        
        self.takePhotoButton = UIButton(type: UIButtonType.RoundedRect)
        self.takePhotoButton.setTitle("Take Photo", forState: UIControlState.Normal)
        self.takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.takePhotoButton.addTarget(self, action: "takePhoto:", forControlEvents: UIControlEvents.TouchUpInside)
        self.takePhotoButton.layer.borderWidth = 1.0
        self.takePhotoButton.layer.borderColor = UIColor.blackColor().CGColor
        
        self.choosePhotoButton = UIButton(type: UIButtonType.RoundedRect)
        self.choosePhotoButton.setTitle("Select Photo", forState: UIControlState.Normal)
        self.choosePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.choosePhotoButton.addTarget(self, action: "selectPhoto:", forControlEvents: UIControlEvents.TouchUpInside)
        self.choosePhotoButton.layer.borderWidth = 1.0
        self.choosePhotoButton.layer.borderColor = UIColor.blackColor().CGColor
        
        
        self.buttonsPanel = UIView()
        self.buttonsPanel.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonsPanel.addSubview(self.takePhotoButton)
        self.buttonsPanel.addSubview(self.choosePhotoButton)
        self.buttonsPanel.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(self.buttonsPanel)
        
        self.setupConstraints()
        
    }
    
    private func setupConstraints() {
        let views = ["takePhotoButton": self.takePhotoButton, "choosePhotoButton": self.choosePhotoButton]
        
        self.view.addConstraint(NSLayoutConstraint(item: self.showImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200))
        self.view.addConstraint(NSLayoutConstraint(item: self.showImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200))

        self.view.addConstraint(NSLayoutConstraint(item: self.showImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 100))
        self.view.addConstraint(NSLayoutConstraint(item: self.showImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.takePhotoButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonsPanel, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.takePhotoButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonsPanel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10))
        self.view.addConstraint(NSLayoutConstraint(item: self.takePhotoButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 150))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.choosePhotoButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonsPanel, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.choosePhotoButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonsPanel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -10))
        self.view.addConstraint(NSLayoutConstraint(item: self.choosePhotoButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 150))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.buttonsPanel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.buttonsPanel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 0.20, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.buttonsPanel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -49))
        
        
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let chosenImage = editingInfo![UIImagePickerControllerOriginalImage] as! UIImage
        self.showImageView.image = chosenImage
        self.showImageView.layer.cornerRadius = self.showImageView.frame.size.width / 2
//        self.showImageView.layer.cornerRadius = 10.0
        self.showImageView.clipsToBounds = true
        self.showImageView.layer.borderWidth = 1.0
        self.showImageView.layer.borderColor = UIColor.blueColor().CGColor
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func takePhoto(sender:UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = .Camera
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "Error", message: "Device has not built in camera", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            alertVC.addAction(okButton)
            
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    func selectPhoto(sender:UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}
