import XCTest

import Day1Tests
import Day2Tests
import Day3Tests
import Day4Tests
import Day5Tests
import Day6Tests
import Day7Tests
import Day8Tests
import Day9Tests
import Day10Tests

var tests = [XCTestCaseEntry]()
tests += Day1Tests.allTests()
tests += Day2Tests.allTests()
tests += Day3Tests.allTests()
tests += Day4Tests.allTests()
tests += Day5Tests.allTests()
tests += Day6Tests.allTests()
tests += Day7Tests.allTests()
tests += Day8Tests.allTests()
tests += Day9Tests.allTests()
tests += Day10Tests.allTests()
XCTMain(tests)
