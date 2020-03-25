//
//  UpdateTrainController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class UpdateTrainController: UIViewController {

    @IBOutlet weak var trainIDText: UITextField!
    @IBOutlet weak var trainNameText: UITextField!
    @IBOutlet weak var sourceNameText: UITextField!
    @IBOutlet weak var sourceLatitudeText: UITextField!
    @IBOutlet weak var sourceLongitudeText: UITextField!
    @IBOutlet weak var sourceAddressText: UITextField!
    @IBOutlet weak var destinationNameText: UITextField!
    @IBOutlet weak var destinationLatitudeText: UITextField!
    @IBOutlet weak var destinationLongitudeText: UITextField!
    @IBOutlet weak var destinationAddressText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateTrain(_ sender: CustomButton) {
        guard let trainID = Int(trainIDText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct train ID", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let train = AppDelegate.trains.searchTrain(id: trainID) else {
            let alertController = UIAlertController(title: "Alert:", message: "Train \(trainID) not exists", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let name = trainNameText.text, !name.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct train name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let sourcename = sourceNameText.text, !sourcename.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct source name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let sourcelatitude = Double(sourceLatitudeText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct source latitude", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let sourcelongitude = Double(sourceLongitudeText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct source longitude", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let sourceaddress = sourceAddressText.text, !sourceaddress.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct source address", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let destinationname = destinationNameText.text, !destinationname.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct destination name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let destinationlatitude = Double(destinationLatitudeText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct destination latitude", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let destinationlongitude = Double(destinationLongitudeText.text!) else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct destination longitude", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let destinationaddress = destinationAddressText.text, !destinationaddress.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct destination address", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        train.line = name
        train.source = Stop(name: sourcename, location: Location(latitude: sourcelatitude, longitude: sourcelongitude), address: sourceaddress)
        train.destination = Stop(name: destinationname, location: Location(latitude: destinationlatitude, longitude: destinationlongitude), address: destinationaddress)
        
        let alertController = UIAlertController(title: "Success:", message: "Successfully create a train", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        trainNameText.text = ""
        sourceNameText.text = ""
        sourceLatitudeText.text = ""
        sourceLongitudeText.text = ""
        sourceAddressText.text = ""
        destinationNameText.text = ""
        destinationLatitudeText.text = ""
        destinationLongitudeText.text = ""
        destinationAddressText.text = ""
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
