//
//  NavigationView.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 23/01/2022.
//

import UIKit

protocol NavigationViewDelegate: AnyObject {
    func navigationView(_ navigationView: NavigationView, textFieldEditingDidEnd text: String)
}

class NavigationView: UIView {

    weak var delegate: NavigationViewDelegate?

    let textFieldView = TextFieldView()
    let returnButton = UIButton()
    let forwardButton = UIButton()
    let addFilterButton = UIButton()
    let showCurrentFiltersButton = UIButton()

    private let mainHorizontalStack = UIStackView()
    private let navigationButtonsHorizontalStack = UIStackView()
    private let filterButtonsHorizontalStack = UIStackView()

    var textFieldHeight: CGFloat = 0
    var navigationViewHeight: CGFloat = 0
    var textfieldText = String() {
        didSet {
            textFieldView.txtField.text = textfieldText
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

    @objc func textFieldDidEndEditing(_ sender: UITextField) {
        delegate?.navigationView(self, textFieldEditingDidEnd: sender.text!)
    }

    @objc func adjusjForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        guard let keyboardViewEndFrame = superview?.convert(keyboardScreenEndFrame, from: superview?.window) else { return }

        if textFieldView.txtField.isSelected &&
            notification.name == UIResponder.keyboardWillShowNotification {
            UIView.animate(withDuration: 0.5, delay: 0, options: []) { [self] in
                superview?.transform = CGAffineTransform(translationX: 0, y: -(keyboardViewEndFrame.height - navigationViewHeight - textFieldHeight))
            }
        } else {
            superview?.transform = .identity
        }
    }
}

// MARK: - NavigationView Configurations
private extension NavigationView {
    func addViews() {
        addTextFieldView()
        addButtonsHorizontalStackView()
        addButtonsView()
    }

    func configure() {
        backgroundColor = R.color.navigationViewColors.backgroundColor()
        textFieldView.fieldSettings = .browserField
        textFieldHeight = textFieldView.txtField.bounds.size.height
        navigationViewHeight = bounds.size.height + 20

        configureHorizontalStacks()
        configureButtons()
    }

    func bind() {
        textFieldView.txtField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)

        addObserverToNotificationCenter()
    }

    func addObserverToNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.adjusjForKeyboard(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(adjusjForKeyboard(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func addButtonsView() {
        mainHorizontalStack.addArrangedSubview(navigationButtonsHorizontalStack)
        mainHorizontalStack.addArrangedSubview(filterButtonsHorizontalStack)

        navigationButtonsHorizontalStack.addArrangedSubview(returnButton)
        navigationButtonsHorizontalStack.addArrangedSubview(forwardButton)

        filterButtonsHorizontalStack.addArrangedSubview(addFilterButton)
        filterButtonsHorizontalStack.addArrangedSubview(showCurrentFiltersButton)
    }

    // MARK: - Horizontal Stacks Configurations
    func configureHorizontalStacks() {
        mainHorizontalStack.axis = .horizontal
        mainHorizontalStack.distribution = .fillEqually

        if traitCollection.verticalSizeClass == .regular, traitCollection.horizontalSizeClass == .regular {
            mainHorizontalStack.spacing = 200
        }

        navigationButtonsHorizontalStack.axis = .horizontal
        navigationButtonsHorizontalStack.distribution = .fillEqually

        filterButtonsHorizontalStack.axis = .horizontal
        filterButtonsHorizontalStack.distribution = .fillEqually
    }

    // MARK: - NavigationView Buttons Configurations
    func configureButtons() {
        returnButton.setImage(R.image.chevronLeft(), for: .normal)
        returnButton.tintColor = R.color.navigationViewColors.buttonTintColor()

        forwardButton.setImage(R.image.chevronRight(), for: .normal)
        forwardButton.tintColor = R.color.navigationViewColors.buttonTintColor()

        addFilterButton.setImage(R.image.noteTextBadgePlus(), for: .normal)
        addFilterButton.tintColor = R.color.navigationViewColors.buttonTintColor()

        showCurrentFiltersButton.setImage(R.image.eyeCircle(), for: .normal)
        showCurrentFiltersButton.tintColor = R.color.navigationViewColors.buttonTintColor()
    }
}

// MARK: - NavigationView UI Elements Constraints
private extension NavigationView {
    private func addTextFieldView() {
        self.addSubview(textFieldView)
        textFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-10)
            $0.trailing.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(52)
            $0.height.equalTo(66)
        }
    }

    private func addButtonsHorizontalStackView() {
        self.addSubview(mainHorizontalStack)
        mainHorizontalStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
}

#if DEBUG
import SwiftUI
@available(iOS 13, *)
struct NavigationViewRepresentable: UIViewRepresentable {
    typealias UIViewType = NavigationView

    func updateUIView(_ uiView: UIViewType, context: Context) {}

    func makeUIView(context: Context) -> NavigationView {
        NavigationView()
    }
}

@available(iOS 13, *)
struct NavigationViewRepresentablePreview: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationViewRepresentable()
                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .bottom)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
