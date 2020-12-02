import XCTest

import Day1Tests
import Day2Tests

var tests = [XCTestCaseEntry]()
tests += Day1Tests.allTests()
tests += Day2Tests.allTests()
XCTMain(tests)
