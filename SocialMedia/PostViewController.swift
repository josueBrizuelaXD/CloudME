//
//  PostViewController.swift
//  SocialMedia
//
//  Created by Josh on 10/1/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageHeightCons: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func postPressed(_ sender: AnyObject) {
        
        guard let image = selectedImage.image, let imgData = UIImageJPEGRepresentation(image, 0.8) else { return }
        
    
        ///add to database
        
        if let user = FIRAuth.auth()?.currentUser {
            let userPath = databaseRef.child("users/\(user.uid)").child("posts").childByAutoId()
            let postKey = userPath.key
            
            if textView.text != nil {
            let text = textView.text as NSString
                
                
              //get reference to the path for pictures
                
                let storageRef = storage.reference(forURL: "gs://social-hero-f91c2.appspot.com/users/\(user.uid)/pictures/\(postKey)/\(text).jpeg")
                let picturePath = storageRef.fullPath
                let _ = storageRef.put(imgData, metadata: nil, completion: {
                    metadata, error in
                    
                    if error == nil {
                        userPath.setValue(["key": postKey, "caption": text, "picturePath": picturePath])

                    }
                    
                })

                
                dismiss(animated: true, completion: nil)
            }
            
        }
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


