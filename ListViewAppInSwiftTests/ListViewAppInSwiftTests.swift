//
//  ListViewAppInSwiftTests.swift
//  ListViewAppInSwiftTests
//
//  Created by Reetesh Kumar on 08/04/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import XCTest
@testable import ListViewAppInSwift

class ListViewAppInSwiftTests: XCTestCase {
    
    var vc: ViewController = ViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc.myTableView = UITableView(frame: self.vc.view.bounds, style: .grouped)
        vc.myTableView.delegate = self.vc
        vc.myTableView.dataSource = self.vc
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.vc.myTableView = nil
        super.tearDown()
    }
    
    func testThatViewLoads() {
        XCTAssertNotNil(self.vc.view, "View not initiated properly")
    }
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(self.vc.myTableView, "TableView not initiated")
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(self.vc .conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testThatTableViewHasDataSource() {
        XCTAssertNotNil(self.vc.myTableView.dataSource, "Table datasource cannot be nil")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue(self.vc.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(self.vc.myTableView.delegate, "Table delegate cannot be nil")
    }
    
}
