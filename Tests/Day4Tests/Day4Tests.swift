import XCTest

@testable import Day4

final class Day4Tests: XCTestCase {
    let testInput = """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929

    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm

    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in
    """
    
    let invalidTestData = """
    eyr:1972 cid:100
    hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

    iyr:2019
    hcl:#602927 eyr:1967 hgt:170cm
    ecl:grn pid:012533040 byr:1946

    hcl:dab227 iyr:2012
    ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

    hgt:59cm ecl:zzz
    eyr:2038 hcl:74454a iyr:2023
    pid:3556412378 byr:2007
    """
    
    let validTestData = """
    pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
    hcl:#623a2f

    eyr:2029 ecl:blu cid:129 byr:1989
    iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

    hcl:#888785
    hgt:164cm byr:2001 iyr:2015 cid:88
    pid:545766238 ecl:hzl
    eyr:2022

    iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
    """
    
    func testPart1() {
        let passports = Day4.parse(testInput)
        let result = Day4.part1(passports)
        XCTAssertEqual(result, 2)
    }
    
    func testInvalidPassports() {
        let passports = Day4.parse(invalidTestData)
        let result = Day4.part2(passports)
        XCTAssertEqual(result, 0)
    }
    
    func testValidPassports() {
        let passports = Day4.parse(validTestData)
        let result = Day4.part2(passports)
        XCTAssertEqual(result, 4)
    }
    
    func testBirthYear() {
        XCTAssertFalse(PassportField.birthYear.isValid("1919"))
        XCTAssertTrue(PassportField.birthYear.isValid("1920"))
        XCTAssertTrue(PassportField.birthYear.isValid("2002"))
        XCTAssertFalse(PassportField.birthYear.isValid("2003"))
    }
    
    func testIssueYear() {
        XCTAssertFalse(PassportField.issueYear.isValid("2009"))
        XCTAssertTrue(PassportField.issueYear.isValid("2010"))
        XCTAssertTrue(PassportField.issueYear.isValid("2020"))
        XCTAssertFalse(PassportField.issueYear.isValid("2021"))
    }
    
    func testExpirationYear() {
        XCTAssertFalse(PassportField.expirationYear.isValid("2019"))
        XCTAssertTrue(PassportField.expirationYear.isValid("2020"))
        XCTAssertTrue(PassportField.expirationYear.isValid("2030"))
        XCTAssertFalse(PassportField.expirationYear.isValid("2031"))
    }
    
    func testHeight() {
        XCTAssertFalse(PassportField.height.isValid("149cm"))
        XCTAssertTrue(PassportField.height.isValid("150cm"))
        XCTAssertTrue(PassportField.height.isValid("193cm"))
        XCTAssertFalse(PassportField.height.isValid("194cm"))
        
        XCTAssertFalse(PassportField.height.isValid("58in"))
        XCTAssertTrue(PassportField.height.isValid("59in"))
        XCTAssertTrue(PassportField.height.isValid("76in"))
        XCTAssertFalse(PassportField.height.isValid("77in"))
        
        XCTAssertFalse(PassportField.height.isValid("150"))
        XCTAssertFalse(PassportField.height.isValid("194"))
        XCTAssertFalse(PassportField.height.isValid("59"))
        XCTAssertFalse(PassportField.height.isValid("76"))
        XCTAssertFalse(PassportField.height.isValid("cm"))
        XCTAssertFalse(PassportField.height.isValid("in"))
    }
    
    func testHairColor() {
        XCTAssertTrue(PassportField.hairColor.isValid("#012345"))
        XCTAssertTrue(PassportField.hairColor.isValid("#abcdef"))
        XCTAssertTrue(PassportField.hairColor.isValid("#123abc"))
        XCTAssertFalse(PassportField.hairColor.isValid("#123abz"))
        XCTAssertFalse(PassportField.hairColor.isValid("123abc"))
        XCTAssertFalse(PassportField.hairColor.isValid("#00000"))
        XCTAssertFalse(PassportField.hairColor.isValid("#0000000"))
    }
    
    func testEyeColor() {
        XCTAssertTrue(PassportField.eyeColor.isValid("amb"))
        XCTAssertTrue(PassportField.eyeColor.isValid("blu"))
        XCTAssertTrue(PassportField.eyeColor.isValid("brn"))
        XCTAssertTrue(PassportField.eyeColor.isValid("gry"))
        XCTAssertTrue(PassportField.eyeColor.isValid("grn"))
        XCTAssertTrue(PassportField.eyeColor.isValid("hzl"))
        XCTAssertTrue(PassportField.eyeColor.isValid("oth"))
        XCTAssertFalse(PassportField.eyeColor.isValid("wat"))
        XCTAssertFalse(PassportField.eyeColor.isValid(""))
        XCTAssertFalse(PassportField.eyeColor.isValid("amber"))
    }
    
    func testPassportID() {
        XCTAssertTrue(PassportField.passportID.isValid("000000001"))
        XCTAssertTrue(PassportField.passportID.isValid("999999999"))
        XCTAssertTrue(PassportField.passportID.isValid("012345678"))
        XCTAssertFalse(PassportField.passportID.isValid("0123456789"))
        XCTAssertFalse(PassportField.passportID.isValid("aaaaaaaaa"))
    }
    
    func testCountryID() {
        XCTAssertTrue(PassportField.countryID.isValid(""))
        XCTAssertTrue(PassportField.countryID.isValid("a"))
        XCTAssertTrue(PassportField.countryID.isValid("UK"))
        XCTAssertTrue(PassportField.countryID.isValid("United Kingdom"))
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testInvalidPassports", testInvalidPassports),
        ("testValidPassports", testValidPassports),
        ("testBirthYear", testBirthYear),
        ("testIssueYear", testIssueYear),
        ("testExpirationYear", testExpirationYear),
        ("testHeight", testHeight),
        ("testHairColor", testHairColor),
        ("testEyeColor", testEyeColor),
        ("testPassportID", testPassportID),
        ("testCountryID", testCountryID),
    ]
}
