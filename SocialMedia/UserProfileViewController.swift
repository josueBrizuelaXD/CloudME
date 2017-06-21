//
//  UserProfileViewController.swift
//  SocialMedia
//
//  Created by Josh on 12/30/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

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
    
    @IBAction func signout(_ sender: Any) {
        
        do {
            try FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let error {
           print("error: \(error)")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let flow = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        let width = UIScreen.main.bounds.size.width
        flow.itemSize = CGSize(width: width, height: 400)
        flow.minimumInteritemSpacing = 3
        flow.minimumLineSpacing = 3
        
        //round the profile pic corners
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.layer.borderWidth = 6
        profilePic.layer.borderColor = UIColor.white.cgColor
        
        //get the user first , so we can retrive the pics.
        if let user = FIRAuth.auth()?.currentUser {
            
            
            databaseRef.child("users").child(user.uid).child("posts").observe(.value, with: {
                snapshot in
                print("Josh: values are \(snapshot.childrenCount)")
     
                var i = 0
                for child  in snapshot.children {
                    i += 1
                    
                    print("Josh: child called \(i)")
                    
                    if let snap = child as? FIRDataSnapshot {
                        
                        if let dict = snap.value as? [String: Any] {
                            if let postKey = dict["key"] as? String, let picturePath = dict["picturePath"] as? String {
                                
                                let pathRef = storage.reference(withPath: picturePath)
                                
                                
                                print("pathRef is \(pathRef)")
                                SDImageCache.shared().queryDiskCache(forKey: postKey, done: {
                                    image , imageCachedType in
                                    
                                    if image != nil {
                                        
                                        let post = Post(key: postKey, image: image!)
                                        
                                        self.posts.append(post)
                                       

                                        self.collectionView.reloadData()
                                        
                                        print("image found in \(imageCachedType)")
                                        
                                    } else {
                                        
                                        //download the image if not cached.
                                     let downloadTask = pathRef.data(withMaxSize: 1024 * 1024 * 6, completion: {
                                            data, error in
                                            
                                            if error == nil {
                                                print("data downloaded")
                                                let image = UIImage(data: data!)!
                                                SDImageCache.shared().store(image, forKey: postKey)
                                                let post = Post(key: postKey, image: image)
                                                
                                                self.posts.append(post)
                                               

                                                self.collectionView.reloadData()
                                                
                                                
                                                
                                            } else {
                                                print("Josh: error downloading the image \(error)")
                                            }
                                        })
                                        
                                        
                                    }
                                    
                                })
                                
                                
                            }
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
            })
            
            
        }
        
        print("josh: view didload method called")
        
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
