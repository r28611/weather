//
//  MyCitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class MyCitiesTableViewController: UITableViewController {
    
    var myCities = [City]()
    var cityNames = [String]()
    var selectedCity: City?
    let weatherService = WeatherService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CityCell", bundle: nil),
                           forCellReuseIdentifier: "CityCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        for (index, cityName) in cityNames.enumerated() {
            weatherService.currentWeather(city: cityName) { [weak self] weather in
                self?.myCities[index].currentWeather = weather
                self?.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell {
            let city = self.myCities[indexPath.row]
            
            cell.configure(city: city)
            return cell
        }
        return CityCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = myCities[indexPath.row]
        
        performSegue(withIdentifier: "to_weekForecast", sender: self)
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_weekForecast" {
            if let destination = segue.destination as? WeekForecastViewController {
                destination.city = selectedCity
            }
        }
    }
    
    
    @IBAction func unwindFromTableViewController (_ segue: UIStoryboardSegue) {
        guard let tableViewController = segue.source as? AllCitiesTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
        
        let city = tableViewController.cities[indexPath.row]
        
        //чтобы не добавлять дубликаты
        if cityNames.contains(city.name) { return }
        
        cityNames.append(city.name)
        myCities.append(city)
        tableView.reloadData()
    }
    
}
