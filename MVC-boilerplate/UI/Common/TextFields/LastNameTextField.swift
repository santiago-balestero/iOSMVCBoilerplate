//
//  LastNameTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/30/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

@IBDesignable class LastNameTextField: FormTextField {

    override func commonInit() {
        super.commonInit()
        label = localized("last_name_label")
        placeholder = localized("last_name_placeholder")
        validations = [.required(requiredError()),
                       .name(invalidError())]
        textContentType = .familyName
    }

    open func requiredError() -> String {
        return "last_name_required_error"
    }

    open func invalidError() -> String {
        return "last_name_invalid_error"
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
