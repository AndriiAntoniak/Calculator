//
//  RoundButton.swift
//  PaigeViewController
//
//  Created by Andrii Antoniak on 10/10/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

@IBDesignable class MyButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    func shake (){
        let animation = CABasicAnimation(keyPath: "position")
       animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        layer.add(animation, forKey: nil)
    }
    func pulse(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.3
        animation.fromValue = 0.95
        animation.toValue = 1.0
        animation.autoreverses = true
        animation.repeatCount = 2
        layer.add(animation, forKey: nil)
    }
}
