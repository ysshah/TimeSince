//
//  EventTableViewCell.swift
//  TimeSince
//
//  Created by Yash Shah on 9/21/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
