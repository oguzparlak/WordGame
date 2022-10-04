//
//  RestartDisplayable.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation
import UIKit

public protocol RestartDisplayable {
  func displayRestartAlert(onRestart: VoidHandler?, onExit: VoidHandler?)
}

public extension RestartDisplayable where Self: UIViewController {
  
  func displayRestartAlert(onRestart: VoidHandler?, onExit: VoidHandler?) {
    let alertController = UIAlertController(
      title: "Game Ended",
      message: "Would you like to restart?",
      preferredStyle: .alert
    )
    alertController.addAction(
      UIAlertAction(
        title: "Restart",
        style: .default,
        handler: { _ in
          onRestart?()
        }
      )
    )
    alertController.addAction(
      UIAlertAction(
        title: "Exit",
        style: .destructive,
        handler: { _ in
          onExit?()
        }
      )
    )
    present(alertController, animated: true)
  }
  
}
