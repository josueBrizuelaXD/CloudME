//
//  SignUpViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var repeatPwdTextField: UITextField!
    
    //MARK: - IBActions
    @IBAction func createBtnPressed(_ sender: AnyObject) {
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITexFieldDelegate implementation
extension SignUpViewController: UITextFieldDelegate {
    
    
}
