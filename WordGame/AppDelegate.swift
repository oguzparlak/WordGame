//
//  AppDelegate.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    initGameScene()
    return true
  }
}

// MARK: - Private

private extension AppDelegate {
  
  func initGameScene() {
    let gameViewModel = GameViewModel()
    let gameController = GameController(viewModel: gameViewModel)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = gameController
  }
}
