//
//  HorizontalButtonPairView.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation
import UIKit
import SnapKit

public final class HorizontalButtonPairView: UIView, Configurable {
  
  // MARK: - Views
  
  private lazy var horizontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    return stackView
  }()
  
  private lazy var positiveButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemGreen
    button.layer.cornerRadius = 8
    return button
  }()
  
  private lazy var negativeButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.backgroundColor = .systemRed
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    return button
  }()
  
  // MARK: - ViewModel
  
  public final class ViewModel {
    public var positiveButtonText: String = ""
    public var negativeButtonText: String = ""
    public var positiveButtonTapHandler: VoidHandler?
    public var negativeButtonTapHandler: VoidHandler?
  }
  
  // MARK: - Init
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Methods
  
  public func configure(with viewModel: ViewModel) {
    positiveButton.setTitle(viewModel.positiveButtonText, for: .normal)
    negativeButton.setTitle(viewModel.negativeButtonText, for: .normal)
    positiveButton.addAction(UIAction(handler: { _ in
      viewModel.positiveButtonTapHandler?()
    }), for: .touchUpInside)
    negativeButton.addAction(UIAction(handler: { _ in
      viewModel.negativeButtonTapHandler?()
    }), for: .touchUpInside)
  }
}

// MARK: - Private

private extension HorizontalButtonPairView {
  
  func initialize() {
    addSubview(horizontalStackView)
    horizontalStackView.addArrangedSubview(positiveButton)
    horizontalStackView.addArrangedSubview(negativeButton)
    setupConstraints()
  }
  
  func setupConstraints() {
    horizontalStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalToSuperview().offset(8)
      $0.height.equalTo(50)
      $0.bottom.equalToSuperview()
    }
  }
}
