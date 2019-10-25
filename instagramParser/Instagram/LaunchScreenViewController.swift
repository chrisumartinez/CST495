//
//  LaunchScreenViewController.swift
//  Instagram
//
//  Created by Chris Martinez on 9/28/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var launchIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchIcon.layer.cornerRadius = 3
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
