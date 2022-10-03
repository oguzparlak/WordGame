//
//  WordPairGenerator.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public final class WordPairGenerator {
  
  // MARK: - Variables
  
  private var words: [Word]
  private let config: GameManager.Config
  
  // MARK: - Init
  
  public init(words: [Word] = [], config: GameManager.Config = .default) {
    self.words = words
    self.config = config
  }
  
  // MARK: - Methods
  
  public func setDataSource(_ words: [Word]) {
    self.words = words
  }
  
  public func generate() -> [WordPair] {
    guard words.count >= config.maxWordPairs else { return [] }
    var pairs: [WordPair] = []
    var shuffledWords = words.shuffled()
    var accumulator: Int = .zero
    shuffledWords.forEach { value in
      if accumulator == config.maxWordPairs { return }
      let isCorrect = shouldPickCorrectPair()
      let currentWord = shuffledWords.removeFirst()
      if isCorrect {
        let correctPair = generateCorrectPair(with: currentWord)
        pairs.append(correctPair)
      } else {
        if let randomWord = shuffledWords.randomElement() {
          pairs.append(generateWrongPair(
            targetWord: currentWord,
            wrongWord: randomWord
          ))
        }
      }
      accumulator += 1
    }
    return pairs
  }
  
  private func generateCorrectPair(with word: Word) -> WordPair {
    WordPair(
      originalWord: word.englishTranslation,
      spanishTranslation: word.spanishTranslation,
      isCorrectTranslation: true
    )
  }
  
  private func generateWrongPair(targetWord: Word, wrongWord: Word) -> WordPair {
    WordPair(
      originalWord: targetWord.englishTranslation,
      spanishTranslation: wrongWord.spanishTranslation,
      isCorrectTranslation: false
    )
  }
  
  private func shouldPickCorrectPair() -> Bool {
    let correctPairGenerationPercentage = config.correctPairGenerationPercentage
    let pickedNumber = Int.random(in: 0..<100)
    let maxSeletableNumber = Int(correctPairGenerationPercentage * 100)
    return pickedNumber <= maxSeletableNumber
  }
}
