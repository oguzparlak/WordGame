//
//  GameController.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import UIKit

public final class GameController: UIViewController {

  // MARK: - Variables
  
  private var viewModel: GameViewModelProtocol?
  
  // MARK: - Lifecycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.setup(errorHandler: { errorMessage in
      debugPrint(errorMessage)
    })
  }
  
  // MARK: - Init
  
  public init(viewModel: GameViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }


}

