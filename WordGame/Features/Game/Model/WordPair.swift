//
//  WordPair.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public struct WordPair: Decodable {
  public let englishTranslation: String
  public let spanishTranslation: String
  
  enum CodingKeys: String, CodingKey {
    case englishTranslation = "text_eng"
    case spanishTranslation = "text_spa"
  }
}
