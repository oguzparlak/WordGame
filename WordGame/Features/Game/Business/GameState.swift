//
//  GameState.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation

public enum GameState {
  case initial
  case next(wordPairViewModel: WordPairView.ViewModel)
  case roundFinished(correctAttemptCount: Int, wrongAttemptCount: Int)
  case gameFinished
  case restart
}
