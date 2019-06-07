//
//  SciCalcTests.swift
//  SciCalcTests
//
//  Created by Tanner Quesenberry on 6/6/19.
//  Copyright © 2019 Tanner Quesenberry. All rights reserved.
//

import XCTest
import Foundation
@testable import SciCalc

class SciCalcTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddition() {
        //given
        var sut = CalculatorLogic()
        
        //when
        sut.setNumber(10.0)
        _ = sut.calculate(symbol: "+")
        sut.setNumber(13.2)
        let result = sut.calculate(symbol: "=")
        
        //then
        XCTAssertEqual(result, 23.2)
    }
    
    func testSubtraction() {
        //given
        var sut = CalculatorLogic()
        
        //when
        sut.setNumber(9.0)
        _ = sut.calculate(symbol: "-")
        sut.setNumber(4.7)
        let result = sut.calculate(symbol: "=")
        
        //then
        XCTAssertEqual(result, 4.3)
    }
    
    func testMultiply() {
        //given
        var sut = CalculatorLogic()
        
        //when
        sut.setNumber(2.0)
        _ = sut.calculate(symbol: "*")
        sut.setNumber(87.1)
        let result = sut.calculate(symbol: "=")
        
        //then
        XCTAssertEqual(result, 174.2)
    }
    
    func testDivision() {
        //given
        var sut = CalculatorLogic()
        
        //when
        sut.setNumber(99.0)
        _ = sut.calculate(symbol: "÷")
        sut.setNumber(11.0)
        let result = sut.calculate(symbol: "=")
        
        //then
        XCTAssertEqual(result, 9.0)
    }
    
    func testDivisionByZero() {
        //given
        var sut = CalculatorLogic()
        
        //when
        sut.setNumber(99.0)
        _ = sut.calculate(symbol: "÷")
        sut.setNumber(0.0)
        let result = sut.calculate(symbol: "=")
        
        //then
        XCTAssertEqual(String(result!), "inf")
    }
    
    func testClear() {
        //given
        var sut = CalculatorLogic()
        
        //when
        sut.setNumber(2.0)
        _ = sut.calculate(symbol: "*")
        sut.setNumber(87.1)
        _ = sut.calculate(symbol: "=")
        let result = sut.calculate(symbol: "C")
        
        //then
        XCTAssertEqual(result, 0.0)
    }
    
    func testPi() {
        //given
        var sut = CalculatorLogic()
        
        //when
        _ = sut.setNumber(0.0)
        let result = sut.calculate(symbol: "π")
        
        //then
        XCTAssertEqual(result, Double.pi)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
