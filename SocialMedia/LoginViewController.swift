//
//  ViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/16/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   
    @IBOutlet weak var bgVisualView: UIVisualEffectView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgVisualView.layer.cornerRadius = 20.0
        bgVisualView.clipsToBounds = true
            }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

}

