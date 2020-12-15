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
import Day11Tests
import Day12Tests
import Day13Tests
import Day14Tests
import Day15Tests

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
tests += Day11Tests.allTests()
tests += Day12Tests.allTests()
tests += Day13Tests.allTests()
tests += Day14Tests.allTests()
tests += Day15Tests.allTests()
XCTMain(tests)
