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
    
    enum Diraction {
        case horizontal
        case vertical
        case diagonal
    }
    
    var direction: Diraction = .horizontal {
        didSet {
            setNeedsLayout()
        }
    }
    
    var gradientStart = CGPoint(x: 0, y: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    var gradientEnd = CGPoint(x: 1, y: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
    
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = gradientStart
        switch direction {
        case .horizontal:
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        case .vertical:
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case .diagonal:
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            gradientLayer.frame = self.bounds
        }

}
