//
//  SignUpViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    let defaultEmailTxt = "E-mail"
    let defaultPasswordTxt = "Password"
    let defaultRepeatPwdTxt = "Repeat password"
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var repeatPwdTextField: UITextField!
    
    //MARK: - IBActions
    @IBAction func createBtnPressed(_ sender: AnyObject) {
        
        guard let username = emailTxtField.text , username != defaultEmailTxt else {
            print("Josh: not user name.....")
            return
        }
        
        guard let password = passwordTxtField.text , password != defaultPasswordTxt else {
            print("Josh: not pass 1.....")
            return
        }
        
        guard let repeatedPass = repeatPwdTextField.text, repeatedPass != defaultRepeatPwdTxt else {
            print("Josh: not pass 2 .....")
            return
        }
        
        let email = username + "@socialhero.com"
        if password == repeatedPass {
            print("Josh: email \(email) and pass is: \(password)")
            FIRAuth.auth()?.createUser(withEmail:email, password:password) {
                user, error in
                if error == nil {
                    print("Josh: user successfully created account")
                    
                    //add user to database
                    databaseRef.child("users").child(user!.uid).setValue(["email":email])
                    
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Josh: error: \(error)")
                    if let error = error as? NSError {
                        let dict = error.userInfo
                        print("error reasonkey: \(dict[NSLocalizedFailureReasonErrorKey]) underlying error: \(dict[NSUnderlyingErrorKey])")
                        
                    }
                }
            }
        } else {
            print("Josh: its not the same password")
        }
        
        
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
        
     
        
        let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        emailLabel.text = "@socialhero.com  "
        emailLabel.textAlignment = .left
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.sizeToFit()
        emailLabel.textColor = UIColor.white
        emailLabel.font = UIFont(name: "Sinhala Sangam MN", size: 17)
        emailTxtField.rightView = emailLabel
        emailTxtField.rightViewMode = .always
    }
    
    //MARK: - Handling touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        repeatPwdTextField.resignFirstResponder()
        
    }
    
    //MARK: - Helper methods
    
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("range length: \(range.length) range location: \(range.location) and replacement string: \(string)")
        if textField == emailTxtField {
            
        }
        return true
    }
}
