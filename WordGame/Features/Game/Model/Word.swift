//
//  Word.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public struct Word: Decodable, Equatable {
  public let englishTranslation: String
  public let spanishTranslation: String
  
  enum CodingKeys: String, CodingKey {
    case englishTranslation = "text_eng"
    case spanishTranslation = "text_spa"
  }
  
  public static func == (lhs: Word, rhs: Word) -> Bool {
    return lhs.englishTranslation == rhs.englishTranslation
  }
}
