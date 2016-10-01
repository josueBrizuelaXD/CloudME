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
        let alert = UIAlertController(title: "Post", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:{
            action in
            
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            if let textField = alert.textFields?[0], let text = textField.text {
                
                ///add to database
                
                if let user = FIRAuth.auth()?.currentUser {
                    let userPath = databaseRef.child("users/\(user.uid)").child("posts").childByAutoId()
                    let postKey = userPath.key
                    
                    userPath.setValue(["key": postKey, "caption": text])
                    let post = Post(key: postKey, caption: text)
                    self.posts.append(post)

                }
                
                self.collectionView?.reloadData()
            }
            
        })
        
        alert.addAction(cancel)
        alert.addAction(okAction)

        alert.addTextField(configurationHandler:nil)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        if let user = FIRAuth.auth()?.currentUser {
            let request = user.profileChangeRequest()
            request.displayName = "josue"
            request.commitChanges(completion: {
                error in
                
                if error == nil {
                    print("success changing name name: \(user.displayName)")
                    
                    
                    //add observer to data changes
                    let _ =   databaseRef.child("users").child(user.uid).child("posts").observe(FIRDataEventType.value, with: {
                        snapshot in
                        
                        
                        if self.posts.isEmpty {
                        for child in snapshot.children {
                            
                            if let snap = child as? FIRDataSnapshot {
                                print("Josh:snaps key are: \(snap.key)")
                                
                                if let dict = snap.value as? [String: Any] {
                                    if let key = dict["key"] as? String, let caption = dict["caption"] as? String {
                                        print("Josh: key: \(key), caption: \(caption)")
                                        
                                            let post = Post(key: key, caption: caption)
                                            self.posts.append(post)
                                            self.collectionView?.reloadData()
                                        
                                        
                                    }
                                }

                                
                            }
                        }
                    }
                })
                    
                }
            })
            
            
        }
        
        
        
        
    }
            
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsFeedCell", for: indexPath) as! PostCollectionViewCell
        let post = posts[indexPath.row]
        cell.captionLabel.text = post.caption
        return cell
    }
    
   
}
