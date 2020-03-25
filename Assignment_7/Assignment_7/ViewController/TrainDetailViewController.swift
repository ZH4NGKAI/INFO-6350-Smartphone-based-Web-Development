//
//  trainDetailViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class TrainDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var train:Train = Train()
    let pickerController = UIImagePickerController()
    var btnTitle = ""
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var trainNameText: UITextField!
    @IBOutlet weak var sourceNameText: UITextField!
    @IBOutlet weak var destinationNameText: UITextField!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var scheduleBtn: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleBtn.isEnabled = false
        stopBtn.isEnabled = false
        selectBtn.isEnabled = false
        pickerController.delegate = self
        if(title == "Edit Train Details"){
            image.image = train.image
            trainNameText.text = train.line
            sourceNameText.text = train.source.name
            destinationNameText.text = train.destination.name
            scheduleBtn.isEnabled = true
            stopBtn.isEnabled = true
            selectBtn.isEnabled = true
        }
        button.setTitle(btnTitle, for:.normal)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if selectBtn.isEnabled {
            sourceNameText.text = train.source.name
            destinationNameText.text = train.destination.name
        }
    }
    
    @IBAction func upload(_ sender: Any) {
        
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            image.image = img
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createOrUpdate(_ sender: Any) {
        guard let img = image.image else {
            let alertController = UIAlertController(title: "Alert:", message: "Upload Image", preferredStyle: .alert)
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
        if title == "Edit Train Details" {
            train.line = name
            train.image = img
        }
        else {
            train = AppDelegate.trains.addTrain(line: name, image: img)
        }
        let alertController = UIAlertController(title: "Success:", message: "Successfully create/update a train", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        selectBtn.isEnabled = true
        scheduleBtn.isEnabled = true
        stopBtn.isEnabled = true
    }
    
    
    @IBAction func selectStation(_ sender: UIButton) {
        guard let sourcename = sourceNameText.text, !sourcename.isEmpty else {
            let alertController = UIAlertController(title: "Alert:", message: "Correct source name", preferredStyle: .alert)
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
        guard let source = train.searchStop(name: sourcename) else {
            let alertController = UIAlertController(title: "Alert:", message: "No existed Stop", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let destination = train.searchStop(name: destinationname) else {
            let alertController = UIAlertController(title: "Alert:", message: "No existed Stop", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        train.source = source
        train.destination = destination
        
        let alertController = UIAlertController(title: "Success:", message: "Station selected", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "StopTableSegue" {
            let vc = segue.destination as! StopTableViewController
            vc.train = self.train
        }
        else if segue.identifier == "ScheduleTableSegue" {
            let vc = segue.destination as! ScheduleTableViewController
            vc.train = self.train
        }
    }
    

}
