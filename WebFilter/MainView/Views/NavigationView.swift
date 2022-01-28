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

    override func layoutSubviews() {
        super.layoutSubviews()
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let darkBlur = UIBlurEffect(style: .systemUltraThinMaterialDark)
            blurEffectView.effect = darkBlur
        } else {
            let lightBlur = UIBlurEffect(style: .systemUltraThinMaterialLight)
            blurEffectView.effect = lightBlur
        }
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
        textFieldView.snp.makeConstraints { make in
            make.height.equalTo(66)
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(-10)
        }
    }

    private func addButtonsHorizontalStackView() {
        self.addSubview(buttonsHorizontalStack)
        buttonsHorizontalStack.snp.makeConstraints { make in
            make.top.equalTo(textFieldView.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview().inset(20)
        }
    }

    private func addButtonsView() {
        navigationButtonsHorizontalStack.addArrangedSubview(returnButton)
        returnButton.snp.makeConstraints { make in
            make.width.equalTo(20)
        }

        navigationButtonsHorizontalStack.addArrangedSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
            make.width.equalTo(20)
        }

        filterButtonsHorizontalStack.addArrangedSubview(addFilterButton)
        addFilterButton.snp.makeConstraints { make in
            make.width.equalTo(20)
        }

        filterButtonsHorizontalStack.addArrangedSubview(showCurrentFiltersButton)
        showCurrentFiltersButton.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
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
        let buttonsConfig = UIImage.SymbolConfiguration(weight: .bold)

        let returnButtonImage = UIImage(systemName: "chevron.left", withConfiguration: buttonsConfig)?.withRenderingMode(.alwaysTemplate)
        let forwardButtonImage = UIImage(systemName: "chevron.right", withConfiguration: buttonsConfig)?.withRenderingMode(.alwaysTemplate)
        let addFilterButtonImage = UIImage(systemName: "note.text.badge.plus", withConfiguration: buttonsConfig)?.withRenderingMode(.alwaysTemplate)
        let showSelectedFiltersButtonImage = UIImage(systemName: "eye.circle", withConfiguration: buttonsConfig)?.withRenderingMode(.alwaysTemplate)

        returnButton.setImage(returnButtonImage, for: .normal)
        returnButton.tintColor = R.color.navigationView.buttonTintColor()
        
        forwardButton.setImage(forwardButtonImage, for: .normal)
        forwardButton.tintColor = R.color.navigationView.buttonTintColor()

        addFilterButton.setImage(addFilterButtonImage, for: .normal)
        addFilterButton.tintColor = R.color.navigationView.buttonTintColor()

        showCurrentFiltersButton.setImage(showSelectedFiltersButtonImage, for: .normal)
        showCurrentFiltersButton.tintColor = R.color.navigationView.buttonTintColor()
    }
}
