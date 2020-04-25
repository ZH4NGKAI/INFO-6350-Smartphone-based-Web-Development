//
//  LogoutController.swift
//  Messenger
//
//  Created by mac on 4/23/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CometChatPro

class LogoutController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, URLSessionDelegate {
    
    let pickerController = UIImagePickerController()
    @IBOutlet weak var userImage: Avatar!
       @IBOutlet weak var userName: UITextField!
    let user = CometChat.getLoggedInUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        userImage.set(image: self.user?.avatar ?? "", with: self.user?.name ?? "")
        userName.text = user?.name
        // Do any additional setup after loading the view.
    }
   
    
//    @IBAction func pickImage(_ sender: Any) {
//        pickerController.sourceType = .photoLibrary
//        present(pickerController, animated: true, completion: nil)
//    }
//
//    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let img = info[.originalImage] as? UIImage {
//            userImage.image = img
//            let imageData = img.jpegData(compressionQuality: 0.2)
//
//            if(imageData == nil )  { return }
//
//
//
//
//            let uploadScriptUrl = NSURL(string:"http://209.6.156.186:8080/image/image_upload.php")
//            let request = NSMutableURLRequest(url: uploadScriptUrl! as URL)
//            request.httpMethod = "POST"
//            request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
//
//            let configuration = URLSessionConfiguration.default
//            let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
//
//
//            let task = session.uploadTask(with: request as URLRequest, from: imageData!)
//            task.resume()
//        }
//        pickerController.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func logOut(_ sender: Any) {
        // Declare Alert
        let dialogMessage = UIAlertController(title: "⚠️ Warning!", message: "Are you sure you want to Logout?", preferredStyle: .alert)

        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 CometChat.logout(onSuccess: { (success) in
                     DispatchQueue.main.async {
                         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let viewController = mainStoryboard.instantiateViewController(withIdentifier: "loginController") as! LoginController
                         UIApplication.shared.keyWindow?.rootViewController = viewController
                         let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: "Logged out successfully.", duration: .short)
                        snackbar.show()
                         }
                 }) { (error) in
                     DispatchQueue.main.async {
                       let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: error.errorDescription, duration: .short)
                        snackbar.show()
                     }
                 }
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)

        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
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
