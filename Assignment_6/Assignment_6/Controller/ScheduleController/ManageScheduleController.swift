//
//  ManageScheduleController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class ManageScheduleController: UIViewController {

    @IBOutlet weak var mbtaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createSchedule(_ sender: CustomButton) {
        let createScheduleController = CreateScheduleController(nibName: "CreateScheduleView", bundle: nil)
        createScheduleController.modalTransitionStyle = .flipHorizontal
               self.present(createScheduleController, animated: true, completion: nil)
    }
    
    @IBAction func deleteSchedule(_ sender: CustomButton) {
        let deleteScheduleController = DeleteScheduleController(nibName: "DeleteScheduleView", bundle: nil)
        deleteScheduleController.modalTransitionStyle = .flipHorizontal
               self.present(deleteScheduleController, animated: true, completion: nil)
    }
    
    @IBAction func updateSchedule(_ sender: CustomButton) {
        let updateScheduleController = UpdateScheduleController(nibName: "UpdateScheduleView", bundle: nil)
        updateScheduleController.modalTransitionStyle = .flipHorizontal
               self.present(updateScheduleController, animated: true, completion: nil)
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
