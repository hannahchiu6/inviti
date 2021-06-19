//
//  InvitiTests.swift
//  invitiTests
//
//  Created by Hannah.C on 19.06.21.
//

import XCTest
@testable import inviti

class InvitiTests: XCTestCase {

//    var sut: InvitiTests!
    var sut: CreateOptionViewModel!

    
    override func setUpWithError() throws {
        try super.setUpWithError()
//        sut = InvitiTests()
        sut = CreateOptionViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()

    }

    func testOptionStartTimeCaculation() throws {
        // 1. given
        let time = 12
        let date = Date.init(millis: 1623520800000)

         // 2. when
        sut.onStartTimeChanged(time, date: date)

         // 3. then
        XCTAssertEqual(sut.option.startTime, 1623564000000, "StartTime caculation is wrong")
    }

    func testOptionEndTimeCaculation() throws {
        // 1. given
        let startTime = 20
        let date = Date.init(millis: 1623520800000)

         // 2. when
        sut.onEndTimeChanged(startTime, date: date)

         // 3. then
        XCTAssertEqual(sut.option.endTime, 1623596400000, "EndTime caculation is wrong")
    }

}
