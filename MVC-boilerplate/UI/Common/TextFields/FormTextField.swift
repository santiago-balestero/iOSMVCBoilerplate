//
//  FormTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/24/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

import SwiftMaskTextfield

enum TexfFieldState {
    case blurred, regular, disabled
}

@IBDesignable class FormTextField: UIView {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var formContainer: UIView!

    @IBOutlet weak var fieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputTextField: SwiftMaskTextfield!

    @IBOutlet weak var progressContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var showHidePasswordContainer: UIView!
    @IBOutlet weak var showHidePasswordButton: UIButton!

    @IBOutlet weak var bottomMessageLabel: UILabel!

    // MARK: - Inspectables

    @IBInspectable var isLoading: Bool = false {
        didSet {
            updateProgressIndicator()
        }
    }

    @IBInspectable open var formatPattern: String {
        get {
            return inputTextField.formatPattern
        }
        set {
            inputTextField.formatPattern = newValue
        }
    }

    @IBInspectable var error: String? = nil {
        didSet {
            updateBottomMessage()
        }
    }

    @IBInspectable var placeholder: String? = nil {
        didSet {
            updatePlaceholder()
        }
    }

    @IBInspectable var message: String? = nil {
        didSet {
            updateBottomMessage()
        }
    }

    @IBInspectable var label: String? = nil {
        didSet {
            updateLabel()
        }
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateFormContainer()
        }
    }

    // MARK: - Public properties
    var onFocusLost: (FormTextField) -> Void = { textField in
        textField.validate()
    }

    var text: String? {
        get {
            return inputTextField.text
        }
        set {
            inputTextField.text = newValue
        }
    }

    var textContentType: UITextContentType? {
        get {
            return inputTextField.textContentType
        }
        set {
            inputTextField.textContentType = newValue
            var isPassword = false
            if #available(iOS 12, *) {
                isPassword = newValue == .password || newValue == .newPassword
            } else {
                isPassword = newValue == .password
            }
            showHidePasswordContainer.isHidden = !isPassword
            updateTextFieldSecurity(isSecureTextEntry: isPassword)
        }
    }

    var keyboardType: UIKeyboardType {
        get {
            return inputTextField.keyboardType
        }
        set {
            inputTextField.keyboardType = newValue
        }
    }

    var isEnabled: Bool {
        return inputTextField.isEnabled
    }

    var state: TexfFieldState = .regular {
        didSet {
            inputTextField.isEnabled = state == .regular
            updateStatusUI()
        }
    }

    var validations: [InputValidation] = []

    weak var nextView: UIView?

    // MARK: - private properties
    private let roundedContainerRadius: CGFloat = 24
    private let roundedFieldPadding: CGFloat = 16

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open func commonInit() {
        let bundle = Bundle(for: FormTextField.self)
        bundle.loadNibNamed(FormTextField.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = UIColor.InputFields.defaultBackground
        inputLabel.font = UIFont.InputFields.label
        inputLabel.textColor = UIColor.InputFields.label
        inputTextField.font = UIFont.InputFields.input
        inputTextField.textColor = UIColor.InputFields.input
        inputTextField.delegate = self
        bottomMessageLabel.font = UIFont.InputFields.error
        bottomMessageLabel.textColor = UIColor.InputFields.error

        showHidePasswordButton.apply(style: .primary,
                                     title: localized("show_password_button"),
                                     font: UIFont.Buttons.showHide)

        updateLabel()
        updatePlaceholder()
        updateBottomMessage()
        updateProgressIndicator()
        updateFormContainer()
    }

    override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() {
            inputTextField.becomeFirstResponder()

            return true
        }
        return false
    }

    // MARK: - Actions
    @IBAction func showHideButtonAction(_ sender: Any) {
        updateTextFieldSecurity(isSecureTextEntry: !inputTextField.isSecureTextEntry)
    }

    @IBAction func formContainerAction(_ sender: Any) {
        inputTextField.becomeFirstResponder()
    }

    func validate() {
        var errorKey: String?
        forLoop: for validation in validations {
            switch validation {
            case .required(let error):
                if text?.isBlank() != false {
                    errorKey = error
                    break forLoop
                } else {
                    break
                }
            case .email(let error):
                if text?.isValidEmail() != true {
                    errorKey = error
                    break forLoop
                } else {
                    break
                }
            case .password(let error):
                if text?.isValidPassword() != true {
                    errorKey = error
                    break forLoop
                } else {
                    break
                }
            case .name(let error):
                if text?.isValidName() != true {
                    errorKey = error
                    break forLoop
                } else {
                    break
                }
            case .custom(let error, let validation):
                if !validation(text) {
                    errorKey = error
                    break forLoop
                } else {
                    break
                }
            }
        }
        error = errorKey != nil ? localized(errorKey!) : nil
    }

    func isValid() -> Bool {
        return error == nil && !isLoading
    }

    // MARK: - Helper Functions
    private func updateTextFieldSecurity(isSecureTextEntry: Bool) {
        inputTextField.isSecureTextEntry = isSecureTextEntry
        showHidePasswordButton.setTitle(title: isSecureTextEntry ?
                                            localized("show_password_button") : localized("hide_password_button"))
    }

    private func updateProgressIndicator() {
        progressContainer.isHidden = !isLoading
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    private func updateBottomMessage() {
        bottomMessageLabel.text = error ?? message
        bottomMessageLabel.textColor = error == nil ? UIColor.InputFields.message : UIColor.InputFields.error
        inputLabel.textColor = error == nil ? UIColor.InputFields.label : UIColor.InputFields.error
        formContainer.borderLine(color: error == nil ? UIColor.InputFields.border : UIColor.InputFields.error)
    }

    private func updateFormContainer() {
        if rounded {
            formContainer.backgroundColor = UIColor.InputFields.roundedBackground
            formContainer.roundCorners(radius: roundedContainerRadius)
            formContainer.borderLine(color: UIColor.InputFields.border)
            fieldLeadingConstraint.constant = roundedFieldPadding
            fieldTrailingConstraint.constant = roundedFieldPadding
        } else {
            formContainer.backgroundColor = UIColor.InputFields.defaultBackground
            fieldLeadingConstraint.constant = 0
            fieldTrailingConstraint.constant = 0
        }
    }

    private func updateStatusUI() {
        formContainer.borderLine(color: state == .blurred ? UIColor.InputFields.borderDisabled : UIColor.InputFields.border)
        updatePlaceholder()
        updateLabel()
    }

    private func updateLabel() {
        inputLabel.textColor = state == .blurred ? UIColor.InputFields.labelDisabled : UIColor.InputFields.label
        inputLabel.text = label
    }

    private func updatePlaceholder() {
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: state == .blurred ? UIColor.InputFields.placeholderDisabled : UIColor.InputFields.placeholder,
                .font: UIFont.InputFields.placeholder
            ])

        inputTextField.placeholder = placeholder
    }
}

extension FormTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        formContainer.borderLine(color: UIColor.InputFields.focusBorder)
        inputTextField.textColor = UIColor.InputFields.focusText
        inputLabel.textColor = UIColor.InputFields.focusLabel
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        onFocusLost(self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        validate()
        if isValid() {
            nextView?.becomeFirstResponder()
            return true
        } else {
            return false
        }
    }
}

enum InputValidation {
    case required(String), email(String), password(String),
    name(String), custom(String, (String?) -> Bool)
}
