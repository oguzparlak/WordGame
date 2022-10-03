//
//  GameController.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import UIKit

public final class GameController: UIViewController {
  
  // MARK: - Views
  
  private lazy var buttonPairView: HorizontalButtonPairView = {
    let buttonPairView = HorizontalButtonPairView()
    let viewModel = HorizontalButtonPairView.ViewModel()
    viewModel.positiveButtonText = GameResources.String.correct
    viewModel.negativeButtonText = GameResources.String.wrong
    viewModel.positiveButtonTapHandler = {
      
    }
    viewModel.negativeButtonTapHandler = {
      
    }
    buttonPairView.configure(with: viewModel)
    return buttonPairView
  }()

  // MARK: - Variables
  
  private var viewModel: GameViewModelProtocol?
  
  // MARK: - Lifecycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
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
  
  // MARK: - Methods
  
}

// MARK: - Private

private extension GameController {
  
  func initialize() {
    view.backgroundColor = .white
    view.addSubview(buttonPairView)
    buttonPairView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
    }
  }
  
}
