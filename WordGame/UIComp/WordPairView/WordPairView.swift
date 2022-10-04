//
//  WordPairView.swift
//  WordGame
//
//  Created by Oguz Parlak on 4.10.2022.
//

import Foundation
import UIKit
import SnapKit

public final class WordPairView: UIView, Configurable {
  
  // MARK: - Views
  
  private lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    return stackView
  }()
  
  private lazy var translatedLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .medium)
    label.textColor = .black
    label.textAlignment = .center
    label.numberOfLines = .zero
    return label
  }()
  
  private lazy var originalLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .medium)
    label.textColor = .black
    label.textAlignment = .center
    label.numberOfLines = .zero
    return label
  }()
  
  // MARK: - ViewModel
  
  public final class ViewModel {
    public var originalText: String = ""
    public var translatedText: String = ""
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
    originalLabel.text = viewModel.originalText
    translatedLabel.text = viewModel.translatedText
  }
}

// MARK: - Private

private extension WordPairView {
  
  func initialize() {
    addSubview(verticalStackView)
    verticalStackView.addArrangedSubview(translatedLabel)
    verticalStackView.addArrangedSubview(originalLabel)
    setupConstraints()
  }
  
  func setupConstraints() {
    verticalStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
