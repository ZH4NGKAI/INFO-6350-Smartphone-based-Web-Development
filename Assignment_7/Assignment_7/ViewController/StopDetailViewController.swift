//
//  StopDetailViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class StopDetailViewController: UIViewController {
    var stop = Stop()
    var train = Train()
    var btnTitle = ""
    @IBOutlet weak var stopNameText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(title == "Edit Stop Details"){
            stopNameText.text = stop.name
            latitudeText.text = String(stop.location.latitude)
            longitudeText.text = String(stop.location.longitude)
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
                if train.searchStop(name: stopname) != nil {
                    let alertController = UIAlertController(title: "Alert:", message: "Stop name existed", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                else {
                    stop.name = stopname
                }
            }
            stop.location = Location(latitude: stoplatitude, longitude: stoplongitude)
            stop.address = stopaddress
        }
        else {
            let stop = Stop(name: stopname, location: Location(latitude: stoplatitude, longitude: stoplongitude), address: stopaddress)
            if !train.addStop(stop: stop) {
                let alertController = UIAlertController(title: "Alert:", message: "Stop name existed", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
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
