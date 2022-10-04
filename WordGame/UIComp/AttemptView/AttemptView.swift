//
//  AttemptView.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation
import UIKit
import SnapKit

public final class AttemptView: UIView, Configurable {
  
  // MARK: - Views
  
  private lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  private lazy var correctAttemptLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .medium)
    label.textColor = .black
    label.textAlignment = .right
    return label
  }()
  
  private lazy var incorrectAttemptLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .medium)
    label.textColor = .black
    label.textAlignment = .right
    return label
  }()
  
  // MARK: - ViewModel
  
  public final class ViewModel {
    public var correctAttemptText: String = ""
    public var incorrectAttemptText: String = ""
    public var correctAttemptCount: Int = .zero
    public var incorrectAttemptCount: Int = .zero
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
    correctAttemptLabel.text = "\(viewModel.correctAttemptText): \(viewModel.correctAttemptCount)"
    incorrectAttemptLabel.text = "\(viewModel.incorrectAttemptText): \(viewModel.incorrectAttemptCount)"
  }
}

// MARK: - Private

private extension AttemptView {
  
  func initialize() {
    addSubview(verticalStackView)
    verticalStackView.addArrangedSubview(correctAttemptLabel)
    verticalStackView.addArrangedSubview(incorrectAttemptLabel)
    setupConstraints()
  }
  
  func setupConstraints() {
    verticalStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
