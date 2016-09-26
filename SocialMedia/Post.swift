//
//  Post.swift
//  SocialMedia
//
//  Created by Josh on 9/26/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit


class Post {
    var userID: String
    var title: String
    var caption: String?
    var image: UIImage?
    
    
    init(userId:String, title: String) {
        self.userID = userId
        self.title = title
    }
}
