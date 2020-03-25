//
//  SStopDetailViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class SStopDetailViewController: UIViewController {
    var schedule: Schedule?
    var train = Train()
    var btnTitle = ""
    var stop = Stop()
    @IBOutlet weak var stopNameText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == "Stop Detail" {
            stopNameText.text = stop.name
            latitudeText.text = String(stop.location.latitude)
            longitudeText.text = String(stop.location.longitude)
            addressText.text = stop.address
            button.isEnabled = false
        }
        button.setTitle(btnTitle, for:.normal)
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
        guard let tempStop = train.searchStop(name: stopname) else {
            let alertController = UIAlertController(title: "Alert:", message: "No existed Stop in Line", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        stop = tempStop
        guard schedule?.addStop(stop: stop) != false else {
            let alertController = UIAlertController(title: "Alert:", message: "Existed Stop in Schedule", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        latitudeText.text = String(stop.location.latitude)
        longitudeText.text = String(stop.location.longitude)
        addressText.text = stop.address
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
