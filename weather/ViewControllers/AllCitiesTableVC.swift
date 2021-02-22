//
//  AllCitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class AllCitiesTableViewController: UITableViewController {
    
    var cities = [
        City(name: "Paris", image: "Paris", forecast: nil),
        City(name: "Prague", image: "Prague", forecast: nil),
        City(name: "Austin", image: "Austin", forecast: nil),
        City(name: "Florencia", image: "Florencia", forecast: nil),
        City(name: "New York", image: "NewYork", forecast: nil),
        City(name: "London", image: "London", forecast: nil),
        City(name: "Bangkok", image: "Bangkok", forecast: nil),
        City(name: "Hong Kong", image: "HongKong", forecast: nil),
        City(name: "Dubai", image: "Dubai", forecast: nil),
        City(name: "Singapore", image: "Singapore", forecast: nil),
        City(name: "Rome", image: "Rome", forecast: nil),
        City(name: "Macau", image: "Macau", forecast: nil),
        City(name: "Istanbul", image: "Istanbul", forecast: nil),
        City(name: "Kuala Lumpur", image: "KualaLumpur", forecast: nil),
        City(name: "Delhi", image: "Delhi", forecast: nil)
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
