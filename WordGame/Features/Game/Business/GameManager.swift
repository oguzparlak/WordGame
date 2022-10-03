//
//  GameManager.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public final class GameManager: AttemptCountable {
  
  // MARK: - AttemptCountable
  
  public var correctAttemps: Int = .zero
  public var incorrectAttempts: Int = .zero
  
  // MARK: - Variables
  
  private var wordPairs: [WordPair] = []
  
  // MARK: - Injected Variables
  
  /// Represents the game configuration
  private let config: Config
  private let wordPairGenerator: WordPairGenerator
  private let fileParser: DecodableParser<[Word]>
  
  // MARK: - Init
  
  public init(config: Config,
              wordPairGenerator: WordPairGenerator = .init(),
              fileParser: DecodableParser<[Word]> = .init(path: "words", fileType: .json)) {
    self.config = config
    self.wordPairGenerator = wordPairGenerator
    self.fileParser = fileParser
  }
  
  // MARK: - Methods
  
  public func setup() throws {
    let parseResult = fileParser.parse()
    switch  parseResult {
    case .success(let words):
      self.wordPairGenerator.setDataSource(words)
      self.wordPairs = wordPairGenerator.generate()
      debugPrint(self.wordPairs)
    case .failure(let error):
      throw error
    }
  }
  
}

// MARK: - Config

public extension GameManager {
  
  struct Config {
    
    /// Represents the maximum amount of pairs to be displayed
    public let maxWordPairs: Int
    
    /// Represents correct pair generation ratio. The default value is 0.25
    public let correctPairGenerationPercentage: Double
    
    init(maxWordPairs: Int, correctPairGenerationPercentage: Double) {
      self.maxWordPairs = maxWordPairs
      self.correctPairGenerationPercentage = correctPairGenerationPercentage
    }
    
    public static var `default`: Config {
      return .init(maxWordPairs: 3, correctPairGenerationPercentage: 0.25)
    }
  }
}
