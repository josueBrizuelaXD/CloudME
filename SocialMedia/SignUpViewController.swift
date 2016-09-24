//
//  SignUpViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    let defaultEmailTxt = "E-mail or username"
    let defaultPasswordTxt = "Password"
    let defaultRepeatPwdTxt = "Repeat password"
    
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
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        repeatPwdTextField.delegate = self
    }
    
    //MARK: - Handling touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        repeatPwdTextField.resignFirstResponder()
        
    }
}

//MARK: - UITexFieldDelegate implementation
extension SignUpViewController: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailTxtField && emailTxtField.text != nil && emailTxtField.text!.isEmpty {
            emailTxtField.text = defaultEmailTxt
            
        } else if textField == passwordTxtField && passwordTxtField.text != nil && passwordTxtField.text!.isEmpty {
            passwordTxtField.isSecureTextEntry = false
            passwordTxtField.text = defaultPasswordTxt
            
        } else if textField == repeatPwdTextField && repeatPwdTextField.text != nil && repeatPwdTextField.text!.isEmpty {
            repeatPwdTextField.isSecureTextEntry = false
            repeatPwdTextField.text = defaultRepeatPwdTxt
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTxtField {
            passwordTxtField.becomeFirstResponder()
            return true
        } else if textField ==  passwordTxtField {
            repeatPwdTextField.becomeFirstResponder()
            return true
        } else if textField == repeatPwdTextField {
            repeatPwdTextField.resignFirstResponder()
            return true
        }
        
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case emailTxtField:
            if emailTxtField.text! == defaultEmailTxt {
                emailTxtField.clearsOnBeginEditing = true
            } else {
                emailTxtField.clearsOnBeginEditing = false
            }
            return true
            
        case passwordTxtField:
            if passwordTxtField.text! == defaultPasswordTxt {
                passwordTxtField.clearsOnBeginEditing = true
                passwordTxtField.isSecureTextEntry = true
            } else {
                passwordTxtField.clearsOnBeginEditing = false
            }
            return true
            
        case repeatPwdTextField:
            if repeatPwdTextField.text! == defaultRepeatPwdTxt {
                repeatPwdTextField.clearsOnBeginEditing = true
                repeatPwdTextField.isSecureTextEntry = true
            } else {
                repeatPwdTextField.clearsOnBeginEditing = false
            }
            return true
            
        default:
            return false
            }
    }
}
