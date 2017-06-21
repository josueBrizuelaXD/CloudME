//
//  HomeViewController.swift
//  SocialMedia
//
//  Created by Josh on 9/25/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UICollectionViewController {
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        //add navigation bar shadow
        let navigationBar = navigationController!.navigationBar
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOpacity = 0.6
        navigationBar.layer.masksToBounds = false
        
        //set the collectionview cell size and spacing
        let flow = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let width = UIScreen.main.bounds.size.width
        flow.itemSize = CGSize(width: width, height: 400)
        flow.minimumLineSpacing = 30
        
        if let user = FIRAuth.auth()?.currentUser {
            let request = user.profileChangeRequest()
            request.displayName = "josue"
            request.commitChanges(completion: {
                error in
                
                if error == nil {
                    print("success changing name : \(user.displayName)")
                    
                    var i = 1
                    //add observer to data changes
                    let _ =   databaseRef.child("users").child(user.uid).child("posts").observe(.childAdded, with: {
                        snapshot in
                        
                        print("times called \(i)")
                        i += 1
                
                        if let dict = snapshot.value as? [String: Any] {
                            if let key = dict["key"] as? String, let picturePath = dict["picturePath"] as? String {
                                
                                let pathRef = storage.reference(withPath: picturePath)
                                
                                
                                print("pathRef is \(pathRef)")
                                SDImageCache.shared().queryDiskCache(forKey: key, done: {
                                    image , imageCachedType in
                                    
                                    if image != nil {
                                        
                                        let post = Post(key: key, image: image!)
                                        
                                        self.posts.append(post)
                                        
                                        print("image found in \(imageCachedType)")
                                        
                                    } else {
                                        
                                        //download the image if not cached.
                                        pathRef.data(withMaxSize: 1024 * 1024 * 6, completion: {
                                            data, error in
                                            
                                            if error == nil {
                                                print("data downloaded")
                                                let image = UIImage(data: data!)!
                                                SDImageCache.shared().store(image, forKey: key)
                                                let post = Post(key: key, image: image)
                                                
                                                self.posts.append(post)
                                                
                                                
                                                
                                            } else {
                                                print("Josh: error downloading the image \(error)")
                                            }
                                        })
                                        
                                        
                                    }
                                    
                                    self.collectionView?.reloadData()
                                    
                                })
                                
                                
                            }
                        }
                
                })
                    
                }
            })
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
            
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsFeedCell", for: indexPath) as! PostCollectionViewCell
        let post = posts[indexPath.row]
        cell.postImage.image = post.image
     
        if let caption = post.caption {
            cell.captionLabel.text = caption
        }
        return cell
    }
    
   
}
