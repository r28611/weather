//
//  MyCitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit
import CoreData

class MyCitiesTableViewController: UITableViewController {
    
    var myCities = [City]()
    var cityNames = [String]()
    var selectedCity: City?
    let weatherService = WeatherService()
    
    private lazy var appDelegare: AppDelegate? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate
    }()
    
    private lazy var context: NSManagedObjectContext? = {
        let context = appDelegare?.persistentContainer.viewContext
        return context
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyCities()
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
    
    func getMyCities() {
        if let context = self.context {

        let results = try! context.fetch(MyCity.fetchRequest()) as! [MyCity]
            results.forEach { city in
                self.myCities.append(City(name: city.name, image: city.image, currentWeather: nil, forecast: nil))
                self.cityNames.append(city.name)
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
        
        if let context = self.context,
           let application = self.appDelegare {
            let newCity = MyCity(context: context)
            newCity.name = city.name
            newCity.image = city.image
            application.saveContext()
        }

    }
    
}
