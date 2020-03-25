//
//  ViewController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mbtaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func manageTrain(_ sender: CustomButton) {
        let manageTrainController = ManageTrainController(nibName: "ManageTrainView", bundle: nil)
        manageTrainController.modalTransitionStyle = .flipHorizontal
               self.present(manageTrainController, animated: true, completion: nil)
    }
    
    @IBAction func manageSchedule(_ sender: CustomButton) {
        let manageScheduleController = ManageScheduleController(nibName: "ManageScheduleView", bundle: nil)
        manageScheduleController.modalTransitionStyle = .flipHorizontal
               self.present(manageScheduleController, animated: true, completion: nil)
    }
    
    @IBAction func manageStop(_ sender: CustomButton) {
        let manageStopController = ManageStopController(nibName: "ManageStopView", bundle: nil)
        manageStopController.modalTransitionStyle = .flipHorizontal
               self.present(manageStopController, animated: true, completion: nil)
    }
    
    @IBAction func searchAndDisplay(_ sender: CustomButton) {
        let manageDisplayController = ManageDisplayController(nibName: "ManageDisplayView", bundle: nil)
        manageDisplayController.modalTransitionStyle = .flipHorizontal
               self.present(manageDisplayController, animated: true, completion: nil)
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
