//
//  MyCitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class MyCitiesTableViewController: UITableViewController {

    var cities = [City]()
    var cityNames = [String]()
    var selectedCity: City?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
            cell.cityNameLabel.text = cities[indexPath.row].name
            cell.cityImage.image = cities[indexPath.row].image
            
            return cell
        }
        return CityCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = cities[indexPath.row]
        
        performSegue(withIdentifier: "to_weekForecast", sender: self)
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_weekForecast" {
            if let destination = segue.destination as? WeatherForecastViewController {
                destination.city = selectedCity
            }
        }
    }
    
    
    @IBAction func unwindFromTableViewController (_ segue: UIStoryboardSegue) {
        guard let tableViewController = segue.source as? CitiesTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
        
        let city = tableViewController.cities[indexPath.row]
        
        //чтобы не добавлять дубликаты
        if cityNames.contains(city.name) { return }
        
        cityNames.append(city.name)
        cities.append(city)
        tableView.reloadData()
    }

}
