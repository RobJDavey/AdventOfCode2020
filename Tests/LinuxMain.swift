import XCTest

import Day1Tests
import Day2Tests
import Day3Tests

var tests = [XCTestCaseEntry]()
tests += Day1Tests.allTests()
tests += Day2Tests.allTests()
tests += Day3Tests.allTests()
XCTMain(tests)
