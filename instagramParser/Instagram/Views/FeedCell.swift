//
//  FeedCell.swift
//  Instagram
//
//  Created by Chris Martinez on 10/2/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class FeedCell: UITableViewCell {

    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
