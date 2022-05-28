
@IBDesignable class CurrentPasswordTextField: PasswordTextField {

    override func commonInit() {
        super.commonInit()
        label = localized("current_password_title")
        placeholder = localized("current_password_placeholder")
        validations = [.required("password_required_error")]
        textContentType = .password
    }
}
