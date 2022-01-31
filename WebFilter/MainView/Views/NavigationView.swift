//
//  NavigationView.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 23/01/2022.
//

import UIKit
import SnapKit

protocol NavigationViewDelegate: AnyObject {
    func navigationView(_ navigationView: NavigationView, textFieldEditingDidEnd text: String)
}

class NavigationView: UIView {

    weak var delegate: NavigationViewDelegate?

    var textfieldText = String() {
        didSet {
            textFieldView.txtField.text = textfieldText
        }
    }

    private let textFieldView = TextFieldView()
    let returnButton = UIButton()
    let forwardButton = UIButton()
    let addFilterButton = UIButton()
    let showCurrentFiltersButton = UIButton()

    private let buttonsHorizontalStack = UIStackView()
    private let navigationButtonsHorizontalStack = UIStackView()
    private let filterButtonsHorizontalStack = UIStackView()
    private var blurEffectView = UIVisualEffectView(effect: nil)

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureBlurEffect()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configure()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        addBackgroundView()
        addTextFieldView()
        addButtonsHorizontalStackView()
        addButtonsView()
    }

    private func configure() {
        configureBlurEffect()
        textFieldView.fieldSettings = .browserField
        configureButtonsHorizontalStack()
        configureNavigationButtonsHorizontalStack()
        configureFilterButtonsHorizontalStack()
        configureButtons()
    }

    private func bind() {
        textFieldView.txtField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
    }

    @objc func textFieldEditingDidEnd(_ sender: UITextField) {
        delegate?.navigationView(self, textFieldEditingDidEnd: sender.text!)
    }

    // MARK: - NavigationView UIElements Constraints
    private func addBackgroundView() {
        self.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addTextFieldView() {
        self.addSubview(textFieldView)
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.snp.makeConstraints { make in
            make.height.equalTo(66)
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(-10)
        }
    }

    private func addButtonsHorizontalStackView() {
        self.addSubview(buttonsHorizontalStack)
        buttonsHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsHorizontalStack.snp.makeConstraints { make in
            make.top.equalTo(textFieldView.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview().inset(20)
        }
    }

    private func addButtonsView() {
        navigationButtonsHorizontalStack.addArrangedSubview(returnButton)
        navigationButtonsHorizontalStack.addArrangedSubview(forwardButton)
        filterButtonsHorizontalStack.addArrangedSubview(addFilterButton)
        filterButtonsHorizontalStack.addArrangedSubview(showCurrentFiltersButton)
    }

    // MARK: - Horizontal Stacks Configurations
    private func configureButtonsHorizontalStack() {
        buttonsHorizontalStack.axis = .horizontal
        buttonsHorizontalStack.distribution = .fillEqually

        if traitCollection.verticalSizeClass == .regular, traitCollection.horizontalSizeClass == .regular {
            buttonsHorizontalStack.spacing = 200
        }

        buttonsHorizontalStack.addArrangedSubview(navigationButtonsHorizontalStack)
        buttonsHorizontalStack.addArrangedSubview(filterButtonsHorizontalStack)
    }

    private func configureNavigationButtonsHorizontalStack() {
        navigationButtonsHorizontalStack.axis = .horizontal
        navigationButtonsHorizontalStack.distribution = .fillEqually
    }

    private func configureFilterButtonsHorizontalStack() {
        filterButtonsHorizontalStack.axis = .horizontal
        filterButtonsHorizontalStack.distribution = .fillEqually
    }

    // MARK: - NavigationView Buttons Configurations
    private func configureButtons() {
        returnButton.setImage(R.image.navigationView.chevronLeft(), for: .normal)
        returnButton.tintColor = R.color.navigationView.buttonTintColor()

        forwardButton.setImage(R.image.navigationView.chevronRight(), for: .normal)
        forwardButton.tintColor = R.color.navigationView.buttonTintColor()

        addFilterButton.setImage(R.image.navigationView.noteTextBadgePlus(), for: .normal)
        addFilterButton.tintColor = R.color.navigationView.buttonTintColor()

        showCurrentFiltersButton.setImage(R.image.navigationView.eyeCircle(), for: .normal)
        showCurrentFiltersButton.tintColor = R.color.navigationView.buttonTintColor()
    }

    // MARK: - Blur Effect Configurations
    private func configureBlurEffect() {
        switch traitCollection.userInterfaceStyle {
        case .unspecified, .light:
            if #available(iOS 13, *) {
                blurEffectView.effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
            } else {
                blurEffectView.effect = UIBlurEffect(style: .extraLight)
                blurEffectView.alpha = 0.5
            }
        case .dark:
            if #available(iOS 13, *) {
                blurEffectView.effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            } else {
                blurEffectView.effect = UIBlurEffect(style: .dark)
                blurEffectView.alpha = 0.5
            }
        @unknown default:
            blurEffectView.effect = nil
        }
    }
}
