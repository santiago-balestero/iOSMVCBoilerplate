//
//  FirstNameTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/30/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

@IBDesignable class FirstNameTextField: FormTextField {

    override func commonInit() {
        super.commonInit()
        label = localized("first_name_label")
        placeholder = localized("first_name_placeholder")
        textContentType = .givenName
        validations = [.required(requiredError()),
                       .name(invalidError())]
    }

    open func requiredError() -> String {
        return "first_name_required_error"
    }

    open func invalidError() -> String {
        return "first_name_invalid_error"
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
