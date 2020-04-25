//
//  ViewController.swift
//  Messenger
//
//  Created by mac on 4/22/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CometChatPro

class LoginController: UIViewController {

    @IBOutlet weak var uidtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        CometChat.login(UID: uidtext.text!, apiKey: Constants.apiKey, onSuccess: { (user) in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = storyboard.instantiateViewController(withIdentifier: "barController") as! BarController
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true, completion: nil)
            }
            print("Login successful : " + user.stringValue())
        }) { (error) in
            
                DispatchQueue.main.async {
                  let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: error.errorDescription, duration: .short)
                     snackbar.show()
                }
            
            print("Login failed with error: " + error.errorDescription);
        }
        
    }
}

