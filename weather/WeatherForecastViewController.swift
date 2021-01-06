//
//  WeatherForecastViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class WeatherForecastViewController: UIViewController {

    @IBOutlet weak var dayPicker: DayPicker!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        dayLabel.text = sender.selectedDay?.title
    }
    
}
