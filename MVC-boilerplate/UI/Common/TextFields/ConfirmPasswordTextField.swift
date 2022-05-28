
@IBDesignable class ConfirmPasswordTextField: PasswordTextField {

    var newPassword: String?

    override func commonInit() {
        super.commonInit()
        label = localized("confirm_password_title")
        placeholder = localized("confirm_new_password_placeholder")
        message = localized("password_message")
        validations = [.required("confirm_new_password_required_error"),
                       .password("password_invalid_error"),
                       .custom("new_password_mismatch_required_error", { (confirmPassword) -> Bool in
                        return confirmPassword == self.newPassword
                       })
        ]
        textContentType = .newPassword
    }
}
