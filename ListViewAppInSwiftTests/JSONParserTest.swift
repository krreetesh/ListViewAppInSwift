//
//  JSONParserTest.swift
//  ListViewAppInSwiftTests
//
//  Created by Reetesh on 4/17/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import XCTest
@testable import ListViewAppInSwift

class JSONParserTest: XCTestCase, JSONParserDelegate  {
    
    func testWebServiceData() {
        let _expectation = self.expectation(description: "myTest")
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let jsonController: JSONParseController = JSONParseController()
        jsonController.parseTheJSONData(jsonURLStr: urlString)
        jsonController.delegate = self
        _expectation.fulfill()
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func fetchDataWithModelArray(model: NSMutableArray, titleString: String) {
        
        //test case for Title at index 0
        let resultStringForTitleAtIndex0: String = (model[0] as! DataModel).titleToRow
        let expectedStringForTitleAtIndex0: String = "Beavers"
        XCTAssertEqual(resultStringForTitleAtIndex0, expectedStringForTitleAtIndex0)
        XCTAssertNotNil(expectedStringForTitleAtIndex0,"Expected Title can't be nil")
        
        //test case for Description at index 1
        let resultStringForDescriptionAtIndex1 = (model[1] as! DataModel).descriptionToRow
        XCTAssertNil(resultStringForDescriptionAtIndex1,"Expected Description to be nil")
        XCTAssertEqual(resultStringForDescriptionAtIndex1, nil)
        
        //test case for ImageHref at index 5
        let resultStringForImageHrefAtIndex5 = (model[5] as! DataModel).imageHrefToRow
        let expectedStringForImageHrefAtIndex5 = "http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png"
        XCTAssertEqual(resultStringForImageHrefAtIndex5, expectedStringForImageHrefAtIndex5)
        
        //test case for ImageHref at index 4
        let resultStringForImageHrefAtIndex4 = (model[4] as! DataModel).imageHrefToRow
        XCTAssertEqual(resultStringForImageHrefAtIndex4, nil)
        
        //test case for Title at index 1
        let resultStringForTitleAtIndex1 = (model[1] as! DataModel).titleToRow
        let expectedStringForTitleAtIndex1 = "Flag"
        XCTAssertEqual(resultStringForTitleAtIndex1, expectedStringForTitleAtIndex1)
        XCTAssertNotNil(expectedStringForTitleAtIndex0,"Expected Title can't be nil")
    }
    
}

