//
//  MyUesrsDemoTests.swift
//  MyUesrsDemoTests
//
//  Created by C879403 on 08/06/22.
//

import XCTest
@testable import MyUesrsDemo

class MyUesrsDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConvertDateFormatter() {
        //given
        let expectedDate = "01 Feb 1978"
        let emptyString = ""
        //when
        let givenDateStr = emptyString.convertDateFormat(strDT: "01/02/1978", givenFormat: "dd/MM/yyyy", expectedFormat: "dd MMM yyyy")
        //then
        XCTAssertEqual(givenDateStr, expectedDate)
    }

}
