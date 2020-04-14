//
//  StopDetailViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CoreData

class StopDetailViewController: UIViewController {
    var stop = Stop()
    var btnTitle = ""
    let stopCoreData = StopCoreData()
    var managedContext: NSManagedObjectContext!
    @IBOutlet weak var stopNameText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate
        managedContext = app.persistentContainer.viewContext
        if(title == "Edit Stop Details"){
            stopNameText.text = stop.name
            latitudeText.text = String(stop.latitude)
            longitudeText.text = String(stop.longitude)
            addressText.text = stop.address
        }
        button.setTitle(btnTitle, for:.normal)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createOrUpdate(_ sender: UIButton) {
        guard let stopname = stopNameText.text, !stopname.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let stoplatitude = Double(latitudeText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop latitude", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let stoplongitude = Double(longitudeText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop longitude", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let stopaddress = addressText.text, !stopaddress.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop address", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if title == "Edit Stop Details" {
            if stopname != stop.name {
                if stopCoreData.searchStop(name: stopname, managedContext: managedContext) != nil {
                    let alertController = UIAlertController(title: "Alert:", message: "Stop name existed", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            stop.name = stopname
            stop.latitude = stoplatitude
            stop.longitude = stoplongitude
            stop.address = stopaddress
            stopCoreData.saveContext(managedContext: managedContext)
        }
        else {
            if stopCoreData.searchStop(name: stopname, managedContext: managedContext) != nil {
                let alertController = UIAlertController(title: "Alert:", message: "Stop name Existed", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            stop = stopCoreData.saveStop(name: stopname, latitude: stoplatitude, longditude: stoplongitude, address: stopaddress, managedContext: managedContext)
        }
        let alertController = UIAlertController(title: "Success:", message: "Stop created/updated successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
