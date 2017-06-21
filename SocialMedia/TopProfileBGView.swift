//
//  TopProfileBGView.swift
//  SocialMedia
//
//  Created by Josh on 6/16/17.
//  Copyright © 2017 Josh. All rights reserved.
//

import UIKit

class TopProfileBGView: UIView {


    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = rect
        let color1 = UIColor(red:0.47, green:0.80, blue:0.92, alpha:1.0)
        let color2 = UIColor(red:0.84, green:0.49, blue:0.92, alpha:1.0)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradient, at: 0)
        
    }
   

}
