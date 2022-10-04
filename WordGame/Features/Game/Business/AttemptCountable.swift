//
//  AttemptCountable.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public protocol AttemptCountable: AnyObject {
  var correctAttemps: Int { get set }
  var incorrectAttempts: Int { get set }
}

public extension AttemptCountable {
  
  func incrementCorrectAttempts() {
    correctAttemps += 1
  }
  
  func incrementWrongAttempts() {
    incorrectAttempts += 1
  }
}
