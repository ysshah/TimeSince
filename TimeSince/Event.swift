//
//  Event.swift
//  TimeSince
//
//  Created by Yash Shah on 9/21/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import UIKit
import os.log

class Event:NSObject, NSCoding {

    // MARK: Properties
    var name: String
    var date: Date

    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")

    // MARK: Initialization
    init?(name: String, date: Date) {
        guard !name.isEmpty else {
            return nil
        }
        self.name = name
        self.date = date
    }

    // MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let date = "date"
    }

    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(date, forKey: PropertyKey.date)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for an Event object.", log: OSLog.default, type: .debug)
            return nil
        }

        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as! Date

        // Must call designated initializer.
        self.init(name: name, date: date)
    }

}
