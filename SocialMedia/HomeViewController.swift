//
//  HomeViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/25/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController {
    var posts = [Post]()
    
    
    @IBAction func addPost(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
    }
            
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsFeedCell", for: indexPath)
        return cell
    }
    
   
}
