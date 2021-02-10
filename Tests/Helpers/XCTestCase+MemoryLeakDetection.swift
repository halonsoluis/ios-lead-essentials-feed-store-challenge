//
//  XCTestCase+MemoryLeakDetection.swift
//  Tests
//
//  Created by Hugo Alonso on 10/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import Foundation

extension XCTestCase {

	func checkForMemoryLeaks(for sut: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
		addTeardownBlock { [weak sut] in
			XCTAssertNil(sut, "Potential memory leak", file: file, line: line)
		}
	}
}
