//
//  NewPasswordTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/30/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

@IBDesignable class NewPasswordTextField: PasswordTextField {

    override func commonInit() {
        super.commonInit()
        label = localized("new_password_title")
        placeholder = localized("new_password_placeholder")
        message = localized("password_message")
        validations = [.required("password_required_error"),
                       .password("password_invalid_error")]
        textContentType = .newPassword
    }
}
