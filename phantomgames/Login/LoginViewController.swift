//
//  LoginViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/18.
//

import UIKit

class LoginvViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var username: UITextField!
    @IBOutlet weak private var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
    }
    
    // MARK: IBAction
    
    @IBAction func logingin(_ sender: Any) {
        let enteredUsername = username.text ?? "Admin"
        let enteredPassword = password.text ?? "Pass123"
        if enteredUsername == "" && enteredPassword == "" {
            performSegue(withIdentifier: Constants.SegueIdentifiers.loginSegueIdentifier, sender: self)
        } else {
            showAlert(message: "Login failed. Either the username or the password is wrong.")
        }
    }
    
    // MARK: Functions
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
