//
//  profileViewController.swift
//  tinder_mock
//
//  Created by Chris Martinez on 10/30/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var cardView: UIImageView!
    var cardImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.image = cardImage
    }
    
}
