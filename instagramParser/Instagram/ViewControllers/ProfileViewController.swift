//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Chris Martinez on 10/6/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ProfileViewController: UIViewController{



@IBAction func onLogout(_ sender: Any)
{
    PFUser.logOutInBackground { (error) in
        if (error != nil) {
            print(error.debugDescription)
        }
    }
    self.performSegue(withIdentifier: "logoutSegue", sender: nil)
}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
