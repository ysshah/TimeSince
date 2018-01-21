//
//  EventTableViewController.swift
//  TimeSince
//
//  Created by Yash Shah on 9/21/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import UIKit
import os.log

class EventTableViewController: UITableViewController {

    // MARK: Properties
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem

        // Load any saved events, otherwise load sample data.
        if let savedEvents = loadEvents() {
            events += savedEvents
        } else {
            // Load the sample data
            loadSampleEvents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell")
        }

        let event = events[indexPath.row]
        cell.eventLabel.text = event.name

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")

        cell.dateLabel.text = dateFormatter.string(from: event.date)

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            events.remove(at: indexPath.row)
            saveEvents()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
            case "AddItem":
                os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            case "ShowDetail":
                guard let eventDetailViewController = segue.destination as? EventViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedEventCell = sender as? EventTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedEvent = events[indexPath.row]
                eventDetailViewController.event = selectedEvent
            default:
                fatalError("Unexpected Segue Identifier: \(segue.identifier)")
        }
    }

    // MARK: Actions
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let source = sender.source as? EventViewController, let event = source.event {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: events.count, section: 0)
                events.append(event)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

            // Save the events.
            saveEvents()
        }
    }

    // MARK: Private Methods
    private func loadSampleEvents() {
        guard let event1 = Event(name: "Hello", date: Date(timeIntervalSinceNow: -3600)) else {
            fatalError("Unable to instantiate event1")
        }

        guard let event2 = Event(name: "Hello2", date: Date(timeIntervalSinceNow: -7200)) else {
            fatalError("Unable to instantiate event2")
        }

        events += [event1, event2]
    }

    private func saveEvents() {
        let defaults = UserDefaults(suiteName: "group.timesince")!
        NSKeyedArchiver.setClassName("Event", for: Event.self)
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: events), forKey: "events")

//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path)
//        if isSuccessfulSave {
//            os_log("Events successfully saved.", log: OSLog.default, type: .debug)
//        } else {
//            os_log("Failed to save events.", log: OSLog.default, type: .error)
//        }
    }

    private func loadEvents() -> [Event]? {
        let defaults = UserDefaults(suiteName: "group.timesince")!
        if let data = defaults.object(forKey: "events") as? Data {
            let unarc = NSKeyedUnarchiver(forReadingWith: data)
            unarc.setClass(Event.self, forClassName: "Event")
            return unarc.decodeObject(forKey: "root") as? [Event]
        }
        return nil
//        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
    }

}
