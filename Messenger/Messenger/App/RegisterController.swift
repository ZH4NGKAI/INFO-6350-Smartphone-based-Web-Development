//
//  RegisterController.swift
//  Messenger
//
//  Created by mac on 4/23/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation
import CometChatPro

class RegisterController: UIViewController {

    @IBOutlet weak var uidText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        let uid = uidText.text!
        let name = nameText.text!
        //Create user
        let newUser : User = User(uid: uid, name: name)
        CometChat.createUser(user: newUser, apiKey: Constants.apiKey, onSuccess: { (User) in
            print("User created successfully. \(User.stringValue())")
            //user login
            CometChat.login(UID: uid, apiKey: Constants.apiKey, onSuccess: { (user) in
                DispatchQueue.main.async {
                    self.joinGroup(as: user)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainVC = storyboard.instantiateViewController(withIdentifier: "barController") as! BarController
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true, completion: nil)
                }
                print("Login successful : " + user.stringValue())
            }) { (error) in
                print("Login failed with error: " + error.errorDescription);
            }
            
          }) { (error) in
             print("The error is \(String(describing: error?.description))")
        }
        
       
    }
    
    func joinGroup(as user: User) {
      CometChat.joinGroup(
        GUID: Constants.groupID,
        groupType: .public,
        password: nil,
        onSuccess: { _ in
          print("Group joined successfully!")
        },
        onError: { error in
          print("Error:", error?.errorDescription ?? "Unknown")
      })
    }
}
