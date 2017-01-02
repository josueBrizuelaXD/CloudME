//
//  UserProfileViewController.swift
//  SocialMedia
//
//  Created by Josh on 12/30/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    var posts = [Post]()
    
    
    //MARK: IBOutlets
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postNumberLbl: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBAction func editProfileBtn(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //get the user first , so we can retrive the pics.
        if let user = FIRAuth.auth()?.currentUser {
         
            let _ = databaseRef.child("users").child(user.uid).child("posts").observe(.childAdded, with: {
                
                snapshot in
                
                if let dict = snapshot.value as? [String: Any] {
                    if let key = dict["key"] as? String, let picturePath = dict["picturePath"] as? String {
                        
                        let pathRef = storage.reference(withPath: picturePath)
                        
                        print("pathRef is \(pathRef)")
                        
                        pathRef.data(withMaxSize: 1024 * 1024 * 6, completion: {
                            data, error in
                            
                            if error == nil {
                                print("data downloaded")
                                let image = UIImage(data: data!)!
                                let post = Post(key: key, image: image)
                               
                                self.posts.append(post)
                                self.collectionView?.reloadData()
                                
                                
                            } else {
                                print("Josh: error downloading the image \(error)")
                            }
                        })
                        
                        
                    }
                }
                
            })
            
        }
    }
    
}


extension UserProfileViewController: UICollectionViewDelegate {
    
}

extension UserProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCell", for: indexPath) as! UserProfileCollectionViewCell
        let post = posts[indexPath.row]
        cell.postImage.image = post.image
            
        return cell
    }
}
