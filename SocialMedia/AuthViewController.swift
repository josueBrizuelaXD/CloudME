//
//  ViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/16/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
   //MARK: - IBOutlets
    @IBOutlet weak var txtFieldsContainer: UIView!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: - Actions
    @IBAction func loginBtnPressed(_ sender: AnyObject) {
        guard let userName = userNameTxtField.text else {
            return
        }
        
        guard let password = passwordTxtField.text else {
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail:userName, password: password) {
            _ , error in
            if error != nil {
                print("Josh: user could sign in \(error)")
            }
        }
    }
    
    @IBAction func forgotPwdPressed(_ sender: AnyObject) {
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        FIRDatabase.database().persistenceEnabled = true
        
        txtFieldsContainer.layer.cornerRadius = txtFieldsContainer.bounds.height / 10
        txtFieldsContainer.layer.borderWidth = 0.5
        txtFieldsContainer.layer.borderColor = UIColor.white.cgColor
        txtFieldsContainer.clipsToBounds = true
            }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
//               self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                print("Josh: user is signed in with \(user.email)")
            } else {
                //user not signed in
            }
        }
        
    }
    
    //MARK: - Handling touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
    }

}

