//
//  FileParser.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import Foundation

public protocol FileParser {
  
  associatedtype Target
  
  // MARK: - Variables
  
  var path: String { get }
  var fileType: FileType { get }
  
  // MARK: - Methods
  
  func parse() -> Result<Target, FileError>
}
