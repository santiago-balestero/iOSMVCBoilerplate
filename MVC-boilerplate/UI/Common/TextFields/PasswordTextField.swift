//
//  PasswordTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/30/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

@IBDesignable class PasswordTextField: FormTextField {

    override func commonInit() {
        super.commonInit()
        label = localized("password_label")
        placeholder = localized("password_placeholder")
        validations = [.required("password_required_error")]
        textContentType = .password
    }
}
