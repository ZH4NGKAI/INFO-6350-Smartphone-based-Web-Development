//
//  ManageDisplayController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class ManageDisplayController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func displayTrains(_ sender: CustomButton) {
        let displayTrainController = DisplayTrainController(nibName: "DisplayTrainView", bundle: nil)
        displayTrainController.modalTransitionStyle = .flipHorizontal
               self.present(displayTrainController, animated: true, completion: nil)
    }
    
    @IBAction func searchTrain(_ sender: CustomButton) {
        let searchTrainController = SearchTrainController(nibName: "SearchTrainView", bundle: nil)
        searchTrainController.modalTransitionStyle = .flipHorizontal
               self.present(searchTrainController, animated: true, completion: nil)
    }
    
    @IBAction func searchSchedule(_ sender: CustomButton) {
        let searchScheduleController = SearchScheduleController(nibName: "SearchScheduleView", bundle: nil)
        searchScheduleController.modalTransitionStyle = .flipHorizontal
               self.present(searchScheduleController, animated: true, completion: nil)
    }
    
    @IBAction func searchStop(_ sender: CustomButton) {
        let searchStopController = SearchStopController(nibName: "SearchStopView", bundle: nil)
        searchStopController.modalTransitionStyle = .flipHorizontal
               self.present(searchStopController, animated: true, completion: nil)
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
