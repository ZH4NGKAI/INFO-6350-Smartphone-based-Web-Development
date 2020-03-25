//
//  ManageTrainController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class ManageTrainController: UIViewController {

    @IBOutlet weak var mbtaLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createTrain(_ sender: CustomButton) {
        let createTrainController = CreateTrainController(nibName: "CreateTrainView", bundle: nil)
        createTrainController.modalTransitionStyle = .flipHorizontal
               self.present(createTrainController, animated: true, completion: nil)
    }
    
    @IBAction func deleteTrain(_ sender: CustomButton) {
        let deleteTrainController = DeleteTrainController(nibName: "DeleteTrainView", bundle: nil)
        deleteTrainController.modalTransitionStyle = .flipHorizontal
               self.present(deleteTrainController, animated: true, completion: nil)
    }
    
    @IBAction func updateTrain(_ sender: CustomButton) {
        let updateTrainController = UpdateTrainController(nibName: "UpdateTrainView", bundle: nil)
        updateTrainController.modalTransitionStyle = .flipHorizontal
               self.present(updateTrainController, animated: true, completion: nil)
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
