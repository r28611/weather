//
//  WeekForecastViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class WeekForecastViewController: UIViewController {
    
    var city: City?
    
    @IBOutlet weak var dayPicker: DayPicker!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = self.city {
            weatherImage.image = city.image
            self.title = city.name
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MonthForecastCollectionViewController {
            destination.city = self.city
        }
    }


    @IBAction func detailButton(_ sender: UIButton) {
    }
    
    @IBAction func weekDayPickerChanged(_ sender: DayPicker) {
        dayLabel.text = "\(sender.selectedDay!.title), здесь будет число"
    }
    
}
