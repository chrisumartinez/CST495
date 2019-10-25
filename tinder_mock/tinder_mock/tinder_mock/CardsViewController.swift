//
//  CardsViewController.swift
//  tinder_mock
//
//  Created by Chris Martinez on 10/30/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardOriginCenter: CGPoint!


    @IBOutlet weak var cardView: UIImageView!
    
    override func viewDidLoad() {
        cardOriginCenter = cardView.center
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profileSegue"){
            let destinationViewController = segue.destination as! profileViewController
            destinationViewController.cardImage = self.cardView.image
        }
    }
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let location = sender.location(in: view)

         var rotation = translation.x / 5 * CGFloat(Double.pi / 180)
        
        if sender.state == .began {
            cardOriginCenter = cardView.center
            rotation = -rotation
     
        } else if sender.state == .changed {
            cardView.center.y = cardOriginCenter.y + translation.y
            cardView.center.x = cardOriginCenter.x + translation.x
            cardView.transform = CGAffineTransform(rotationAngle: rotation)
        } else if sender.state == .ended {
            
            if translation.x > 50 {
                UIView.animate(withDuration: 0.2, animations: {self.cardView.center.x += self.view.bounds.width
                }, completion: nil)
            } else if translation.x < -50 {
                UIView.animate(withDuration: 0.2, animations: { self.cardView.center.x -= self.view.bounds.width }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: { self.cardView.center = self.cardOriginCenter }, completion: nil)
            }
        }

    }
}
