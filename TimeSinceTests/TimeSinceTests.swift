//
//  TimeSinceTests.swift
//  TimeSinceTests
//
//  Created by Yash Shah on 9/19/17.
//  Copyright © 2017 Yash Shah. All rights reserved.
//

import XCTest
@testable import TimeSince

class TimeSinceTests: XCTestCase {

    // MARK: Event Class Tests
    func testEventInitializationSucceeds() {
        let event = Event.init(name: "Test", date: Date(timeIntervalSinceNow: 0))
        XCTAssertNotNil(event)
    }

    func testEventInitializationFails() {
        let event = Event.init(name: "", date: Date(timeIntervalSinceNow: 0))
        XCTAssertNil(event)
    }
    
}
