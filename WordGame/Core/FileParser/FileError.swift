//
//  FileError.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public enum FileError: Error, CustomStringConvertible, Equatable {
  
  case pathNotFound
  case dataCorrupted
  case typeMismatch
  case keyNotFound
  case valueNotFound
  case unkown
  
  public var description: String {
    switch self {
    case .pathNotFound:
      return "The provided path is problematic. Please check."
    case .dataCorrupted:
      return "The data is corrupted for the file you wish to parse. Please check."
    case .typeMismatch:
      return "The data does not match with expected target. Please check."
    case .keyNotFound:
      return "One or more keys not found while decoding. Please check."
    case .valueNotFound:
      return "One or more values not found while decoding. Please check."
    case .unkown:
      return "Unkown error. Please check."
    }
  }
  
}
