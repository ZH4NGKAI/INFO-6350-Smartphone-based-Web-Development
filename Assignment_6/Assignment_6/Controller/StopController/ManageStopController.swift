//
//  ManageStopController.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class ManageStopController: UIViewController {

    @IBOutlet weak var mbtaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createStop(_ sender: CustomButton) {
        let createStopController = CreateStopController(nibName: "CreateStopView", bundle: nil)
        createStopController.modalTransitionStyle = .flipHorizontal
               self.present(createStopController, animated: true, completion: nil)
    }
    
    @IBAction func deleteStop(_ sender: CustomButton) {
        let deleteStopController = DeleteStopController(nibName: "DeleteStopView", bundle: nil)
        deleteStopController.modalTransitionStyle = .flipHorizontal
               self.present(deleteStopController, animated: true, completion: nil)
    }
    
    @IBAction func updateStop(_ sender: CustomButton) {
        let updateStopController = UpdateStopController(nibName: "UpdateStopView", bundle: nil)
        updateStopController.modalTransitionStyle = .flipHorizontal
               self.present(updateStopController, animated: true, completion: nil)
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
