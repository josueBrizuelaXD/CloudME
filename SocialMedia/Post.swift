//
//  Post.swift
//  SocialMedia
//
//  Created by Josh on 9/26/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit


class Post {
    var userID: String?
    var caption: String?
    var image: UIImage
    var key : String
    
    init(key: String, image: UIImage) {
       self.key = key
       self.image = image
    }
    
}
