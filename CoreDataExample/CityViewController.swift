//
//  CityViewController.swift
//  CoreDataExample
//
//  Created by hind on 11/4/18.
//  Copyright © 2018 hind. All rights reserved.
//

import UIKit

class CityViewController: UIViewController  ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var cityArray :[CityLib] = []
    override func viewDidLoad() {
        super.viewDidLoad()
     tableView.delegate = self
     tableView.dataSource = self
     self.fatchData()
      self.tableView.reloadData()
     
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cityArray.count
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            let city = cityArray[indexPath.row]
            context.delete(city)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                cityArray = try context.fetch(CityLib.fetchRequest())
            }catch{
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      let oneRecord = cityArray[indexPath.row]
     cell.textLabel?.text = oneRecord.cityName! + "  " + oneRecord.provinceName! + "  " + oneRecord.countryName!
        return cell
    }
    
    func fatchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            cityArray = try context.fetch(CityLib.fetchRequest())
        }
        catch {
            print(error)
        }
    }

}
