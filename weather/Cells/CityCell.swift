//
//  CityCell.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 17.01.2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var cityImage: RoundedView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(city: City) {
        self.cityImage.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        self.cityImage.layer.borderWidth = 2
        
        self.cityNameLabel.text = city.name
        self.cityImage.image = city.image
        if let currentWeather = city.currentWeather {
            self.tempLabel.text = "\(Int(currentWeather.main.temp)) °C"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityNameLabel.text = nil
        self.cityImage.image = nil
    }

}
