//
//  RoundButton.swift
//  SocialMedia
//
//  Created by Josh on 4/9/17.
//  Copyright © 2017 Josh. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
    }
   

}
