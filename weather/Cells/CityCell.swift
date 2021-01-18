//
//  CityCell.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 17.01.2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    
    @IBOutlet weak var gradient: GradientView!
    
    @IBOutlet weak var cityImage: RoundedView! {
        didSet {
            self.cityImage.layer.borderColor = UIColor.white.cgColor
            self.cityImage.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            self.cityNameLabel.textColor = UIColor.white
        }
    }
    
    func configure(city: String, image: UIImage) {
        self.cityNameLabel.text = city
        self.cityImage.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityNameLabel.text = nil
        self.cityImage.image = nil
    }

}
