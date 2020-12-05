import XCTest

import Day1Tests
import Day2Tests
import Day3Tests
import Day4Tests
import Day5Tests

var tests = [XCTestCaseEntry]()
tests += Day1Tests.allTests()
tests += Day2Tests.allTests()
tests += Day3Tests.allTests()
tests += Day4Tests.allTests()
tests += Day5Tests.allTests()
XCTMain(tests)
