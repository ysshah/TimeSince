//
//  EventTableView.swift
//  EventsWidget
//
//  Created by Yash Shah on 9/24/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import UIKit

class EventsWidgetTableView: UITableView {

    // MARK: Properties
    var events = [Event]()

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCellIdentifier", forIndexPath: indexPath)

        let event = events[indexPath.row]
        cell.textLabel?.text = event["title"] as? String
        cell.textLabel?.textColor = UIColor.whiteColor()

        return cell
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
