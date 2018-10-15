//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Bhoomi Kathiriya on 11/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    private let locaionPresenter = LocationPresenter(locationService: LocationService())
    private let locationService: LocationService? = LocationService()

    let strURL = String(format: "%@?lat=%@&lon=%@&appid=%@&units=metric",kBaseURL,"-33.863400","151.211000",kAPIKey)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testParse_Succeeds() {
        /*  toTest.parse("Something that will parse", success: {
         // do nothing, test will pass
         }) {
         // if failure parsing, fail test
         XCTFail()
         }*/
        
        let expectation2 = expectation(description: "Parsing Succeeds")
        
        
        locationService?.createRequest(qMes: "", strURL: strURL, method: "GET", completionBlock: { (arg0) in
            expectation2.fulfill()
            let (output) = arg0
            print("test case output",output)
        }, andFailureBlock: { (failure) in
            XCTFail()
        })
        waitForExpectations(timeout: 600.0) { (_) -> Void in
        }
        
    }
    
    
}
