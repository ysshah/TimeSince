//
//  EventsWidgetTableViewCell.swift
//  EventsWidget
//
//  Created by Yash Shah on 9/24/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import UIKit

class EventsWidgetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
