//
//  GameViewModel.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public protocol GameViewModelProtocol {
  func setup(errorHandler: ((String) -> Void)?)
}

public final class GameViewModel: GameViewModelProtocol {
  
  // MARK: - Variables
  
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
}
