//
//  DetailViewController.swift
//  Instagram
//
//  Created by Chris Martinez on 10/3/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var postImgeView: UIImageView!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post : Post?
    
    @IBAction func onBackButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "returnToFeedSegue", sender: nil)
    }
    override func viewDidLoad() {
        if let post = post{
            captionLabel.text = post.caption
            

            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy"
            let formattedDate = formatter.string(from: post.createdAt!)
            
            createdAtLabel.text = formattedDate
            
            if let imageFile : PFFile = post.media {
                imageFile.getDataInBackground { (data, error) in
                    if (error != nil) {
                        print(error.debugDescription)
                    }
                    else {
                        self.postImgeView.image = UIImage(data: data!)
                    }
                }
            }
            
            
            
        }
        createdAtLabel.sizeToFit()
        captionLabel.sizeToFit()
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
