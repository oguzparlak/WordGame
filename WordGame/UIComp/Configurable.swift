//
//  Configurable.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation

public protocol Configurable {
  
  /// Data type that holds information regarding the Configurable
  associatedtype ViewModel
  
  /// Configurates the Configurable
  func configure(with viewModel: ViewModel)
}
