//
//  NewEmailTextField.swift
//  TeeTimes Alpha v2
//
//  Created by MichelKamil on 1/30/20.
//  Copyright © 2020 TeeTimes. All rights reserved.
//

@IBDesignable class NewEmailTextField: EmailTextField {

    override func commonInit() {
        super.commonInit()

        onFocusLost = { [weak self] _ in
            self?.validate()
            if self?.isValid() == true {
                self?.checkEmailAvailability()
            }
        }
    }

    private func checkEmailAvailability() {

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
