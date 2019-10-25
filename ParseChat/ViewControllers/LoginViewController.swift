//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Chris Martinez on 10/7/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        
      
        
        let username = usernameTextfield.text ?? ""
        let password = passwordTextField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Problem", message: "There was a problem signing In.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true) { }
                return;
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        if((usernameTextfield.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!){
            let alertController = UIAlertController(title: "Incorrect Information", message: "Please Submit a Valid Username or Password.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            alertController.addAction(dismissAction)
            present(alertController, animated: true) { }
            return;
        }
        
        let newUser = PFUser()
        
        newUser.username = usernameTextfield.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                if error._code == 202{
                    print("Username is Taken.")
                }
                let alertController = UIAlertController(title: "Problem", message: "There was a problem signing up.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true) { }
                return;
            } else {
                print("User Registered successfully")

            }
        }
    }
    
    
    
}
