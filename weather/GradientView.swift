//
//  GradientView.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 05.01.2021.
//

import UIKit

class GradientView: UIView {

    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable
    var bottomColor: UIColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
    
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            gradientLayer.frame = self.bounds
        }

}
