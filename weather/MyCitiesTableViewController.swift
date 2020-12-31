//
//  MyCitiesTableViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class MyCitiesTableViewController: UITableViewController {

    var cities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyCitiesTableViewCell {
            cell.myCityLabel.text = cities[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindFromTableViewController (_ segue: UIStoryboardSegue) {
        guard let tableViewController = segue.source as? CitiesTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
        
        let city = tableViewController.sortedCities[indexPath.row]
        
        //чтобы не добавлять дубликаты
        if cities.contains(city) { return }
        
        cities.append(city)
        tableView.reloadData()
    }

}
