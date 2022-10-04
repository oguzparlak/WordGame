//
//  GameViewModel.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public protocol GameViewModelProtocol {
  var gameState: GameState { get }
  var gameStateChangeHandler: ((GameState) -> Void)? { get set }
  func setup(errorHandler: ((String) -> Void)?)
  func start()
  func didSelectAttempt(isCorrect: Bool)
}

public final class GameViewModel: GameViewModelProtocol {
  
  // MARK: - Variables
  
  public private(set) var gameState: GameState = .initial {
    didSet {
      gameStateChangeHandler?(gameState)
    }
  }
  public var gameStateChangeHandler: ((GameState) -> Void)?
  
  private var currentlyDisplayedPair: WordPair? {
    return gameManager.wordPairs.first
  }
  
  // MARK: - Injected Variables
  
  private let gameManager: GameManager
  
  // MARK: - Init
  
  public init(gameManager: GameManager = GameManager(config: .default)) {
    self.gameManager = gameManager
  }
  
  // MARK: - Methods
  
  public func setup(errorHandler: ((String) -> Void)?) {
    do {
      try gameManager.setup()
    } catch {
      errorHandler?(error.localizedDescription)
    }
  }
  
  public func start() {
    gameManager.reset()
    finishRound()
    next()
  }
  
  public func didSelectAttempt(isCorrect: Bool) {
    pickAttempt(isCorrect: isCorrect)
    skip()
    next()
    checkGameEnded()
  }
}

// MARK: - Private

private extension GameViewModel {
  
  func next() {
    guard let currentPair = currentlyDisplayedPair else { return }
    let viewModel = WordPairView.ViewModel()
    viewModel.originalText = currentPair.originalWord
    viewModel.translatedText = currentPair.spanishTranslation
    gameState = .next(wordPairViewModel: viewModel)
  }
  
  func skip() {
    guard gameManager.wordPairs.isEmpty == false else { return }
    gameManager.wordPairs.removeFirst()
  }
  
  func pickAttempt(isCorrect: Bool) {
    guard let currentPair = currentlyDisplayedPair else { return }
    let isCorrectAttempt = isCorrect == currentPair.isCorrectTranslation
    gameManager.onAttempt(isCorrect: isCorrectAttempt)
    finishRound()
  }
  
  func finishRound() {
    gameState = .roundFinished(
      correctAttemptCount: gameManager.correctAttemps,
      wrongAttemptCount: gameManager.incorrectAttempts
    )
  }
  
  func checkGameEnded() {
    let gameEnded = gameManager.isGameEnded()
    if gameEnded { gameState = .gameFinished }
  }
  
}
