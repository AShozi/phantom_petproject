//
//  LoginViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/18.
//

import UIKit

class LoginvViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        password.isSecureTextEntry = true
        
    }
    
    
    @IBAction func Login(_ sender: Any) {
        let enteredUsername = username.text ?? ""
        let enteredPassword = password.text ?? ""
        
        if enteredUsername == "Aphiwe" && enteredPassword == "aphiweshozi" {
            // Successful login
            //                showAlert(message: "Login successful, Welcome Back Aphiwe!")
            performSegue(withIdentifier: "loggedInSegue", sender: Any?.self)
        } else {
            // Failed login
            showAlert(message: "Login failed. Either the username or the password is wrong.")
        }
        
    }
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
