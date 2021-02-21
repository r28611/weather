//
//  AllCitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class AllCitiesTableViewController: UITableViewController {
    
    var cities = [
        City(name: "Paris", image: UIImage(named: "Paris"), forecast: nil),
        City(name: "Prague", image: UIImage(named: "Prague"), forecast: nil),
        City(name: "Austin", image: UIImage(named: "Austin"), forecast: nil),
        City(name: "Florencia", image: UIImage(named: "Florencia"), forecast: nil),
        City(name: "New York", image: UIImage(named: "NewYork"), forecast: nil),
        City(name: "London", image: UIImage(named: "London"), forecast: nil),
        City(name: "Bangkok", image: UIImage(named: "Bangkok"), forecast: nil),
        City(name: "Hong Kong", image: UIImage(named: "HongKong"), forecast: nil),
        City(name: "Dubai", image: UIImage(named: "Dubai"), forecast: nil),
        City(name: "Singapore", image: UIImage(named: "Singapore"), forecast: nil),
        City(name: "Rome", image: UIImage(named: "Rome"), forecast: nil),
        City(name: "Macau", image: UIImage(named: "Macau"), forecast: nil),
        City(name: "Istanbul", image: UIImage(named: "Istanbul"), forecast: nil),
        City(name: "Kuala Lumpur", image: UIImage(named: "KualaLumpur"), forecast: nil),
        City(name: "Delhi", image: UIImage(named: "Delhi"), forecast: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CityCell", bundle: nil),
                           forCellReuseIdentifier: "CityCell")
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell {
            let city = self.cities[indexPath.row]
            cell.configure(city: city)
            cell.tempLabel.isHidden = true
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "addCity", sender: self)
    }
}
