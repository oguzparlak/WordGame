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
  
  public var wordPairs: [WordPair] = []
  
  /// Responsible for generating word pairs with applied config
  private lazy var wordPairGenerator: WordPairGenerator = .init(config: config)
  
  /// Manages the time related business
  private lazy var timerService: TimerServiceProtocol = TimerService(
    targetSeconds: config.secondsForRound
  )
  
  // MARK: - Injected Variables
  
  /// Represents the game configuration
  private let config: Config
  
  /// Responsible for parsing the json file to provide data for the game
  private let fileParser: DecodableParser<[Word]>
  
  // MARK: - Init
  
  public init(config: Config,
              fileParser: DecodableParser<[Word]> = .init(path: "words", fileType: .json)) {
    self.config = config
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
  
  public func observeSeconds(didEndHandler: VoidHandler?) {
    timerService.endHandler = didEndHandler
  }
  
  public func onAttempt(isCorrect: Bool) {
    if isCorrect {
      incrementCorrectAttempts()
    } else {
      incrementWrongAttempts()
    }
  }
  
  public func isGameEnded() -> Bool {
    let reachedMaxWrongAttempts = incorrectAttempts == config.maxWrongAttemptCount
    return wordPairs.isEmpty || reachedMaxWrongAttempts
  }
  
  public func reset() {
    correctAttemps = .zero
    incorrectAttempts = .zero
    resetTimer()
  }
  
  public func resetTimer() {
    timerService.reset()
  }
  
  public func stopTimer() {
    timerService.stop()
  }
  
}

// MARK: - Config

public extension GameManager {
  
  struct Config {
    
    /// Represents the maximum amount of pairs to be displayed.
    /// The default value is 15
    public let maxWordPairs: Int
    
    /// Represents correct pair generation ratio.
    /// The default value is 0.25
    public let correctPairGenerationPercentage: Double
    
    /// Maximum wrong attempt count for a game round.
    /// The default value is 3
    public let maxWrongAttemptCount: Int
    
    /// Amount in seconds that let user play a game round for a specific amount of time.
    /// The default value is 5
    public let secondsForRound: Int
    
    init(maxWordPairs: Int,
         correctPairGenerationPercentage: Double,
         maxWrongAttemptCount: Int,
         secondsForRound: Int) {
      self.maxWordPairs = maxWordPairs
      self.correctPairGenerationPercentage = correctPairGenerationPercentage
      self.maxWrongAttemptCount = maxWrongAttemptCount
      self.secondsForRound = secondsForRound
    }
    
    public static var `default`: Config {
      return .init(
        maxWordPairs: 15,
        correctPairGenerationPercentage: 0.25,
        maxWrongAttemptCount: 3,
        secondsForRound: 5
      )
    }
  }
}
