//
//  SStopDetailViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CoreData

class SStopDetailViewController: UIViewController {
    var schedule: Schedule?
    var btnTitle = ""
    var stop = Stop()
    let stopCoreData = StopCoreData()
    var managedContext : NSManagedObjectContext!
    @IBOutlet weak var stopNameText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == "Stop Detail" {
            stopNameText.text = stop.name
            latitudeText.text = String(stop.latitude)
            longitudeText.text = String(stop.longitude)
            addressText.text = stop.address
            button.isEnabled = false
        }
        button.setTitle(btnTitle, for:.normal)
        let app = UIApplication.shared.delegate as! AppDelegate
        managedContext = app.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addStop(_ sender: UIButton) {
        guard let stopname = stopNameText.text, !stopname.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct stop name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let tempStop = stopCoreData.searchStop(name: stopname, managedContext: managedContext) else {
            let alertController = UIAlertController(title: "Alert:", message: "No existed Stop in Line", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard schedule?.stops?.index(of: tempStop) == NSNotFound else {
            let alertController = UIAlertController(title: "Alert:", message: "Existed Stop in Schedule", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        stop = tempStop
        latitudeText.text = String(stop.latitude)
        longitudeText.text = String(stop.longitude)
        addressText.text = stop.address
        schedule?.addToStops(stop)
        let alertController = UIAlertController(title: "Success:", message: "Stop added successfully", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        return
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
