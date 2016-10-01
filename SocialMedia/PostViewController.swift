//
//  PostViewController.swift
//  SocialMedia
//
//  Created by Josh on 10/1/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageHeightCons: NSLayoutConstraint!
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func postPressed(_ sender: AnyObject) {
    }
    
    @IBAction func getImagePressed(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.isHidden = true
        imageHeightCons.constant = 0
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage.image = image
            selectedImage.isHidden = false
            imageHeightCons.constant = 200
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


