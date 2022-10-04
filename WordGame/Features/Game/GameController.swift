//
//  GameController.swift
//  WordGame
//
//  Created by Oguz Parlak on 2.10.2022.
//

import UIKit

public final class GameController: UIViewController, RestartDisplayable {
  
  // MARK: - Views
  
  private lazy var buttonPairViewModel: HorizontalButtonPairView.ViewModel = {
    let viewModel = HorizontalButtonPairView.ViewModel()
    viewModel.positiveButtonText = GameResources.String.correct
    viewModel.negativeButtonText = GameResources.String.wrong
    viewModel.positiveButtonTapHandler = { [weak self] in
      self?.onAttempt(isCorrect: true)
    }
    viewModel.negativeButtonTapHandler = { [weak self] in
      self?.onAttempt(isCorrect: false)
    }
    return viewModel
  }()
  
  private lazy var buttonPairView: HorizontalButtonPairView = {
    let buttonPairView = HorizontalButtonPairView()
    buttonPairView.configure(with: buttonPairViewModel)
    return buttonPairView
  }()
  
  private lazy var attemptView = AttemptView()
  
  private lazy var wordPairView = WordPairView()

  // MARK: - Variables
  
  private var viewModel: GameViewModelProtocol?
  
  // MARK: - Lifecycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    bindGameState()
    start()
  }
  
  // MARK: - Methods
  
  private func bindGameState() {
    viewModel?.gameStateChangeHandler = { [weak self] state in
      guard let self = self else { return }
      switch state {
      case .initial:
        break
      case .next(let wordPairViewModel):
        self.wordPairView.configure(with: wordPairViewModel)
      case .gameFinished:
        self.displayRestartAlert(onRestart: {
          self.start()
        }, onExit: {
          exit(.zero)
        })
      case .roundFinished(let viewModel):
        self.attemptView.configure(with: viewModel)
      case .timeIsUp:
        self.onAttempt(isCorrect: false, skip: true)
      }
    }
  }
  
  private func start() {
    viewModel?.setup(errorHandler: { errorMessage in
      debugPrint(errorMessage)
    })
    viewModel?.start()
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

// MARK: - View Setup

private extension GameController {
  
  func initialize() {
    view.backgroundColor = .white
    view.addSubview(buttonPairView)
    view.addSubview(attemptView)
    view.addSubview(wordPairView)
    makeConstraints()
  }
  
  func makeConstraints() {
    buttonPairView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
    }
    attemptView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
    wordPairView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  func layoutWordPair(position: WordPairPosition = .middle) {
    wordPairView.snp.updateConstraints {
      let frameHeight = view.frame.height
      let wordPairHeight = wordPairView.frame.height
      let offset: CGFloat = position == .middle ? .zero : frameHeight + wordPairHeight
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(offset)
    }
  }
  
  func onAttempt(isCorrect: Bool, skip: Bool = false) {
    buttonPairViewModel.isEnabled = false
    animate(animation: { [weak self] in
      self?.layoutWordPair(position: .bottom)
    }, completion: { [weak self] in
      if skip {
        self?.viewModel?.nextOnTimerEnd()
      } else {
        self?.viewModel?.didSelectAttempt(isCorrect: isCorrect)
      }
      self?.animate(animation: {
        guard let self = self else { return }
        self.layoutWordPair(position: .middle)
        self.buttonPairViewModel.isEnabled = true
        self.buttonPairView.configure(with: self.buttonPairViewModel)
      })
    })
    buttonPairView.configure(with: buttonPairViewModel)
  }
  
}

// MARK: - Animation

public extension GameController {
  
  enum WordPairPosition {
    case middle
    case bottom
  }
  
}
