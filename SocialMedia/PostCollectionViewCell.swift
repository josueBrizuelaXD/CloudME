//
//  PostCollectionViewCell.swift
//  SocialMedia
//
//  Created by Josh on 9/26/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var profilePicBaseView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //profile base view shadow
        profilePicBaseView.layer.shadowColor = UIColor.black.cgColor
        profilePicBaseView.layer.shadowOffset = CGSize(width: 0, height: 3)
        profilePicBaseView.layer.shadowRadius = 10
        profilePicBaseView.layer.shadowOpacity = 0.7
        profilePicBaseView.layer.masksToBounds = false
        
        //profile baseview corners
        profilePicBaseView.layer.cornerRadius = profilePicBaseView.layer.frame.width / 2
        
        //round the profile pic corners
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.layer.borderWidth = 3
        profilePic.layer.borderColor = UIColor.white.cgColor

        
        //add user name label shadow
        userName.layer.shadowColor = UIColor.black.cgColor
        userName.layer.shadowOffset = CGSize(width: 0, height: 3)
        userName.layer.shadowRadius = 10
        userName.layer.shadowOpacity = 0.7
        userName.layer.masksToBounds = false
        
        //add cell shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        
        
    }
    
}
