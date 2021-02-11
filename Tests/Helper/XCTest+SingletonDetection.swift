//
//  XCTest+SingletonDetection.swift
//  Tests
//
//  Created by Hugo Alonso on 11/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import Foundation

extension XCTestCase {

	func XCTAssertSame(
		firtstReference: AnyObject,
		secondReference: AnyObject,
		message: String = "References are not equal",
		file: StaticString = #filePath, line: UInt = #line){
		
		XCTAssert(firtstReference === secondReference, message, file: file, line: line)
	}
}
