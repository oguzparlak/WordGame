//
//  DecodableParser.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public final class DecodableParser<T: Decodable>: FileParser {
  
  // MARK: - Variables
  
  public private(set) var path: String
  public private(set) var fileType: FileType
  
  // MARK: - Init
  
  public init(path: String, fileType: FileType = .json) {
    self.path = path
    self.fileType = fileType
  }
  
  // MARK: - Methods
  
  public func parse() -> Result<T, FileError> {
    guard let jsonData = data() else {
      return .failure(.pathNotFound)
    }
    do {
      let value = try JSONDecoder().decode(T.self, from: jsonData)
      return .success(value)
    } catch {
      switch error {
      case DecodingError.dataCorrupted:
        return .failure(.dataCorrupted)
      case DecodingError.typeMismatch:
        return .failure(.typeMismatch)
      case DecodingError.keyNotFound:
        return .failure(.keyNotFound)
      case DecodingError.valueNotFound:
        return .failure(.valueNotFound)
      default:
        return .failure(.unkown)
      }
    }
  }
  
}

// MARK: - Private

private extension DecodableParser {
  
  func data(bundle: Bundle = .main) -> Data? {
    guard let url = bundle.url(
      forResource: path,
      withExtension: fileType.rawValue
    ) else { return nil }
    return try? Data(contentsOf: url)
  }
  
}
