//
//  TodayViewController.swift
//  EventsWidget
//
//  Created by Yash Shah on 9/23/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import UIKit
import NotificationCenter
import os.log

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {

    var events = [Event]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        if let savedEvents = loadEvents() {
            events += savedEvents
            if events.count > 2 {
                self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
            }
//            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        if let savedEvents = loadEvents() {
            events.removeAll()
            events += savedEvents
        }

        tableView.reloadData()
        
        completionHandler(NCUpdateResult.newData)
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == NCWidgetDisplayMode.expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: CGFloat(events.count * 44 + 1))
        } else {
            self.preferredContentSize = maxSize
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventsWidgetTableViewCell", for: indexPath) as? EventsWidgetTableViewCell else {
            fatalError("The dequeued cell is not an instance of EventsWidgetTableViewCell")
        }

        let event = events[indexPath.row]
        cell.nameLabel.text = event.name

        let components = Calendar.current.dateComponents([.day, .hour], from: event.date, to: Date.init())
        cell.timeLabel.text = "\(components.day!) days, \(components.hour!) hours"

        return cell
    }

    private func loadEvents() -> [Event]? {
        let defaults = UserDefaults(suiteName: "group.timesince")!
        if let data = defaults.object(forKey: "events") as? Data {
            let unarc = NSKeyedUnarchiver(forReadingWith: data)
            unarc.setClass(Event.self, forClassName: "Event")
            return unarc.decodeObject(forKey: "root") as? [Event]
        }
        return nil
    }
    
}
