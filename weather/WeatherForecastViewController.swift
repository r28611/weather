//
//  WeatherForecastViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
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
            weatherService.loadWeatherData(city: city.name)
            
        }
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func detailButton(_ sender: UIButton) {
    }
    
    @IBAction func weekDayPickerChanged(_ sender: DayPicker) {
        dayLabel.text = "\(sender.selectedDay!.title), здесь будет число"
    }
    
}
