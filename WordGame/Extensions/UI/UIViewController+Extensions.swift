//
//  UIViewController+Extensions.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation
import UIKit

public extension UIViewController {
  
  func animate(animation: VoidHandler?, completion: VoidHandler? = nil) {
    let anim = UIViewPropertyAnimator(
      duration: 0.35,
      curve: UIView.AnimationCurve.linear,
      animations: { [weak self] in
        guard let self = self else { return }
        animation?()
        self.view.layoutIfNeeded()
      }
    )
    anim.addCompletion { position in
      if position == .end {
        completion?()
      }
    }
    anim.startAnimation()
  }
  
}
