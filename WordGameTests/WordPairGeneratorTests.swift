//
//  WordPairGeneratorTests.swift
//  WordGameTests
//
//  Created by Oguz Parlak on 4.10.2022.
//

import XCTest
@testable import WordGame

class WordPairGeneratorTests: XCTestCase {
  
  // MARK: - Variables
  
  private var generator: WordPairGenerator!
  
  private lazy var defaultConfig = GameManager.Config(
    maxWordPairs: 10,
    correctPairGenerationPercentage: 0.25,
    maxWrongAttemptCount: .zero,
    secondsForRound: .zero
  )
  
  private lazy var words: [Word] = [
    Word(englishTranslation: "rule", spanishTranslation: "regla"),
    Word(englishTranslation: "chess", spanishTranslation: "ajedrez"),
    Word(englishTranslation: "jigsaw", spanishTranslation: "puzzle"),
    Word(englishTranslation: "dice", spanishTranslation: "dado"),
    Word(englishTranslation: "man", spanishTranslation: "hombre"),
    Word(englishTranslation: "(to) work", spanishTranslation: "trabajar"),
    Word(englishTranslation: "plan", spanishTranslation: "plan"),
    Word(englishTranslation: "experience", spanishTranslation: "experiencia"),
    Word(englishTranslation: "(to) get married", spanishTranslation: "casarse"),
    Word(englishTranslation: "in love", spanishTranslation: "enamorado"),
    Word(englishTranslation: "lonely", spanishTranslation: "solo")
  ]
  
  // MARK: - Methods
  
  override func setUp() {
    generator = WordPairGenerator(
      words: words,
      config: defaultConfig
    )
  }
  
  override func tearDown() {
    generator = nil
  }

  // MARK: - Test Cases
  
  func testGenerateWithDefaultConfig() {
    let wordPairs = generator.generate()
    XCTAssertEqual(wordPairs.count, defaultConfig.maxWordPairs)
  }
  
  func testGenerateWithAllTrueConfig() {
    generator = allCorrectGenerator()
    let wordPairs = generator.generate()
    let allTrue = wordPairs.allSatisfy { $0.isCorrectTranslation }
    XCTAssertTrue(allTrue)
  }
  
  func testGenerateWithAllFalseConfig() {
    generator = allIncorrectGenerator()
    let wordPairs = generator.generate()
    let allIncorrect = wordPairs.allSatisfy { $0.isCorrectTranslation == false }
    XCTAssertTrue(allIncorrect)
  }
  
}

// MARK: - Dummy

extension WordPairGeneratorTests {
  
  // MARK: - Hundred Percent True Config
  
  func allCorrectGenerator() -> WordPairGenerator {
    .init(words: words, config: allCorrectConfig())
  }
  
  func allIncorrectGenerator() -> WordPairGenerator {
    .init(words: words, config: allIncorrectConfig())
  }
  
  /// Generates %100 correct translated word pairs configuration
  func allCorrectConfig() -> GameManager.Config {
    .init(
      maxWordPairs: 10,
      correctPairGenerationPercentage: 1,
      maxWrongAttemptCount: .zero,
      secondsForRound: .zero
    )
  }
  
  /// Generates %100 incorrect translated word pairs configuration
  func allIncorrectConfig() -> GameManager.Config {
    .init(
      maxWordPairs: 10,
      correctPairGenerationPercentage: .zero,
      maxWrongAttemptCount: .zero,
      secondsForRound: .zero
    )
  }
  
}
