//
//  EmailTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/30/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

@IBDesignable class EmailTextField: FormTextField {

    override func commonInit() {
        super.commonInit()

        label = localized("email_label")
        placeholder = localized("email_placeholder")
        validations = [.required("email_required_error"),
                       .email("email_invalid_error")]
        textContentType = .emailAddress
    }

    override var text: String? {
        get {
            return super.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
            inputTextField.text = newValue
        }
    }
}
