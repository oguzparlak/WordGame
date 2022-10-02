//
//  GameManager.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public protocol GameManagerProtocol {
  var pairs: [WordPair] { get }
  func setup() throws
}

public final class GameManager: GameManagerProtocol {
  
  // MARK: - Variables
  
  public var pairs: [WordPair] = []
  
  // MARK: - Injected Variables
  
  private let fileParser: DecodableParser<[WordPair]>
  
  // MARK: - Init
  
  public init(fileParser: DecodableParser<[WordPair]> = .init(path: "words", fileType: .json)) {
    self.fileParser = fileParser
  }
  
  // MARK: - Methods
  
  public func setup() throws {
    let parseResult = fileParser.parse()
    switch  parseResult {
    case .success(let pairs):
      self.pairs = pairs
    case .failure(let error):
      throw error
    }
  }
  
}
