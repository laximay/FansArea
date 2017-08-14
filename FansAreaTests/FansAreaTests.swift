//
//  FansAreaTests.swift
//  FansAreaTests
//
//  Created by Wen Jing on 2017/6/25.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import XCTest
@testable import FansArea

class FansAreaTests: XCTestCase {
    
    var vc: AreaTableViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = sb.instantiateViewController(withIdentifier: "AreaTableVC")as! AreaTableViewController
        
    }
    
    func testSearchFilter()  {
        vc.viewDidLoad()
        vc.searchFilter(text: "dongcheng")
        print("搜索结果：",vc.searchResult.count,"区域数目", vc.areas.count)
        XCTAssert(vc.searchResult.count == 1)
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
    
}
