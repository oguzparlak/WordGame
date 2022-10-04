//
//  TimerServiceTests.swift
//  WordGameTests
//
//  Created by Oguz Parlak on 4.10.2022.
//

import XCTest
@testable import WordGame

class TimerServiceTests: XCTestCase {
  
  // MARK: - Variables
  
  private var timerService: TimerServiceProtocol!
  
  // MARK: - Methods
  
  override func setUp() {
    timerService = TimerService(targetSeconds: 5)
  }
  
  override func tearDown() {
    timerService = nil
  }

  // MARK: - Test Cases
  
  func testReset() {
    let expectation = self.expectation(description: "TimerTick")
    var timerEnded = false
    timerService.reset()
    timerService.endHandler = {
      timerEnded = true
      expectation.fulfill()
    }
    waitForExpectations(timeout: 5)
    XCTAssertTrue(timerEnded)
  }
  
  func testStop() {
    let expectation = self.expectation(description: "Stop")
    // Start the 5 second configurated timer
    var timerEnded = false
    var stopped = false
    timerService.reset()
    timerService.endHandler = {
      timerEnded = true
      expectation.fulfill()
    }
    // Stop it after 3 seconds elapsed
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
      self.timerService.stop()
      stopped = true
      expectation.fulfill()
    })
    waitForExpectations(timeout: 5)
    // Timer shouldn't be ended
    XCTAssertFalse(timerEnded)
    // Tİmer should be stopped
    XCTAssertTrue(stopped)
  }
  
}
