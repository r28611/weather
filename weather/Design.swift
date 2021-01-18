//
//  Design.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 15.01.2021.
//

import UIKit

class RoundedView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
}

class Shedow: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 3, height: 3)
        
        layer.borderColor = UIColor.white.cgColor
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = false
    }
}
