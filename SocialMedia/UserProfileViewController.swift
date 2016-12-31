//
//  UserProfileViewController.swift
//  SocialMedia
//
//  Created by Josh on 12/30/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
}


extension UserProfileViewController: UICollectionViewDelegate {
    
}

extension UserProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCell", for: indexPath)
            
        return cell
    }
}
