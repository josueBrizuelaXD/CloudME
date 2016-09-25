//
//  HomeViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/25/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBAction func signOutPressed(_ sender: AnyObject) {
        if let _ = FIRAuth.auth()?.currentUser {
         try! FIRAuth.auth()!.signOut()
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
}
