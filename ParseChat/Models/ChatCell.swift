//
//  ChatCell.swift
//  ParseChat
//
//  Created by Chris Martinez on 10/8/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatMessageUsername: UILabel!
    @IBOutlet weak var chatMessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
