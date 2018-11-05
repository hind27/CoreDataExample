//
//  ViewController.swift
//  CoreDataExample
//
//  Created by hind on 11/4/18.
//  Copyright © 2018 hind. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var  CityText: UITextField!
    @IBOutlet weak var provinceText: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    @IBOutlet weak var searchFor: UITextField!
    @IBOutlet weak var countryText: UITextField!
    var context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    
   

    @IBAction func saveBtn(_ sender: Any) {
        let cityName = self.CityText!.text
        let provinceName = self.provinceText!.text
        let countryName = self.countryText!.text
        
        
       //validata input
        if (cityName?.isEmpty)!{
            self.CityText.layer.borderColor = UIColor.red.cgColor
            return }
        else {
            self.CityText.layer.borderColor = UIColor.black.cgColor
        }
        if (provinceName?.isEmpty)!{
            self.provinceText.layer.borderColor = UIColor.red.cgColor
            return }
        else {
            self.provinceText.layer.borderColor = UIColor.black.cgColor
        }
        if (countryName?.isEmpty)!{
            self.countryText.layer.borderColor = UIColor.red.cgColor
            return }
        else {
            self.countryText.layer.borderColor = UIColor.black.cgColor
        }
    let newCity = NSEntityDescription.insertNewObject(forEntityName: "CityLib", into: context)
        newCity.setValue(self.CityText!.text, forKey: "cityName")
        newCity.setValue(self.provinceText!.text, forKey: "provinceName")
        newCity.setValue(self.countryText!.text, forKey: "countryName")
        do
          {
            try context.save()
            self.CityText!.text = ""
            self.provinceText.text = ""
            self.countryText!.text = ""
        } catch
        {
            print(error)
        }
 }
    @IBAction func searchBtn(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CityLib")
        let searchString = self.searchFor?.text
        //request.predicate = NSPredicate(format: "cityName CONTAINS[cd] %@", searchString!) // contains case insensitive
        //request.predicate = NSPredicate(format: "cityName CONTAINS %@", searchString!) // contains case sensitive
        //request.predicate = NSPredicate(format: "cityName LIKE[cd] %@", searchString!) // like case insensitive
        //request.predicate = NSPredicate(format: "cityName ==[cd] %@", searchString!)  // equal case insensitive
        request.predicate = NSPredicate(format: "cityName == %@", searchString!) // equal case sensitive sensitive
        var outputString = " "
        do {
             let result = try context.fetch(request)
             if result.count > 0 {
               for online  in result {
                    let oneCity = (online as AnyObject).value(forKey: "cityName") as! String
                    let oneprovince = (online as AnyObject).value(forKey: "provinceName") as! String
                    let oneCountry = (online as AnyObject).value(forKey: "countryName") as! String
                outputString += oneCity + "  " + oneprovince + "  " + oneCountry + "\n"
                }
             }else {
              outputString = "No Match Found! "
            }
            self.searchResult?.text = outputString
        } catch {
            print(error)
            }
    }
}

