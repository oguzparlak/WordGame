//
//  TimerService.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation

public protocol TimerServiceProtocol {
  var targetSeconds: Int { get }
  var endHandler: VoidHandler? { get set }
  func reset()
  func stop()
}

public final class TimerService: TimerServiceProtocol {
  
  // MARK: - Handlers
  
  public var endHandler: VoidHandler?
  
  // MARK: - Variables
  
  private lazy var remainingSeconds: Int = targetSeconds
  private lazy var timer = Timer()
  
  // MARK: - Injected Variables
  
  public private(set) var targetSeconds: Int
  
  // MARK: - Init
  
  public init(targetSeconds: Int) {
    self.targetSeconds = targetSeconds
  }
  
  // MARK: - Methods
  
  public func reset() {
    remainingSeconds = targetSeconds
    timer.invalidate()
    timer = Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true,
      block: { [weak self] timer in
        guard let self = self else { return }
        if self.remainingSeconds - 1 > 0 {
          self.remainingSeconds -= 1
        } else {
          self.endHandler?()
          timer.invalidate()
        }
      }
    )
  }
  
  public func stop() {
    timer.invalidate()
  }
}
