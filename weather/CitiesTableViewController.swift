//
//  CitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cities.append(City(name: "Paris", image: UIImage(named: "paris"), forecast: nil))
        cities.append(City(name: "Prague", image: UIImage(named: "prague"), forecast: nil))
        cities.append(City(name: "Austin", image: UIImage(named: "austin"), forecast: nil))
        cities.append(City(name: "Florencia", image: UIImage(named: "florencia"), forecast: nil))

        
        tableView.register(UINib(nibName: "CityCell", bundle: nil),
                           forCellReuseIdentifier: "CityCell")
        

    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell {
            let city = self.cities[indexPath.row]
            cell.configure(city: city.name, image: city.image)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "addCity", sender: self)
    }
}
