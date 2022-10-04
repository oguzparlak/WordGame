//
//  DecodableParserTests.swift
//  WordGameTests
//
//  Created by Oguz Parlak on 4.10.2022.
//

import XCTest
@testable import WordGame

class DecodableParserTests: XCTestCase {
  
  // MARK: - Variables
  
  private var parser: DecodableParser<[Word]>!
  
  // MARK: - Methods
  
  override func setUp() {
    parser = defaultParser()
  }
  
  override func tearDown() {
    parser = nil
  }

  // MARK: - Test Cases
  
  func testSuccessfullParse() {
    let words = parser.parse()
    guard case .success(let value) = words else {
      return XCTFail("Parse failed.")
    }
    XCTAssertTrue(value.isEmpty == false)
  }
  
  func testSuccessfullParseCorrectOrder() {
    let words = parser.parse()
    guard case .success(let value) = words else {
      return XCTFail("Parse failed.")
    }
    XCTAssertTrue(value.first?.englishTranslation == "primary school")
  }
  
  func testSuccessfullParseLastItem() {
    let words = parser.parse()
    guard case .success(let value) = words else {
      return XCTFail("Parse failed.")
    }
    XCTAssertTrue(value.last?.englishTranslation == "jigsaw")
  }
  
  func testParserWithWrongKey() {
    let failableParser = dummyParser()
    let parseResult = failableParser.parse()
    XCTAssertEqual(parseResult, .failure(.keyNotFound))
  }
  
  func testTypeMismatchedParser() {
    let failableParser = typeMismatchedParser()
    let parseResult = failableParser.parse()
    XCTAssertEqual(parseResult, .failure(.typeMismatch))
  }
  
  func testWrongPattedParser() {
    parser = wrongPattedParser()
    let parseResult = parser.parse()
    XCTAssertEqual(parseResult, .failure(.pathNotFound))
  }
  
  func testWrongFileTypedParser() {
    parser = wrongFileTypedParser()
    let parseResult = parser.parse()
    XCTAssertEqual(parseResult, .failure(.pathNotFound))
  }
  
  func testDataCorrupted() {
    let parseResult = parser.parse()
    XCTExpectFailure(
      "You need to modify words.json to check dataCorrupted, or add a dummy json file for further testing."
    )
    XCTAssertEqual(parseResult, .failure(.dataCorrupted))
  }
  
  func testValueNotFound() {
    let parseResult = parser.parse()
    XCTExpectFailure(
      "You need to modify words.json to check valueNotFound, or add a dummy json file for further testing."
    )
    XCTAssertEqual(parseResult, .failure(.valueNotFound))
  }

}

// MARK: - Dummy

extension DecodableParserTests {
  
  struct WrongKeyedDecodable: Decodable, Equatable {
    let someUnrelatedKey: String
  }
  
  struct TypeMismatchedDecodable: Decodable, Equatable {
    let id: String
    let name: Int
  }
  
  func defaultParser() -> DecodableParser<[Word]> {
    DecodableParser(
      path: "words",
      fileType: .json
    )
  }
  
  func wrongPattedParser() -> DecodableParser<[Word]> {
    DecodableParser(
      path: "wrongPath",
      fileType: .json
    )
  }
  
  func wrongFileTypedParser() -> DecodableParser<[Word]> {
    DecodableParser(
      path: "wrongPath",
      fileType: .doc
    )
  }
  
  func dummyParser() -> DecodableParser<[WrongKeyedDecodable]> {
    DecodableParser(path: "words", fileType: .json)
  }
  
  func typeMismatchedParser() -> DecodableParser<TypeMismatchedDecodable> {
    DecodableParser(path: "words", fileType: .json)
  }
  
}
