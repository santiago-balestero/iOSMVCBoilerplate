
import UIKit

extension UIAlertController {
    static func alert(title: String, message: String, primaryButtonTitle: String,
                      primaryButtonAction: (() -> Void)? = nil, secondaryButtonTitle: String? = nil,
                      secondaryButtonAction: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let actionBlock = primaryButtonAction {
            alertController.addAction(UIAlertAction(title: primaryButtonTitle,
                                                    style: .default,
                                                    handler: { (_) in
                                                        actionBlock()
            }))
        } else {
            alertController.addAction(UIAlertAction(title: primaryButtonTitle,
                                                    style: .default))
        }

        if let title = secondaryButtonTitle, let actionBlock = secondaryButtonAction {
            alertController.addAction(UIAlertAction(title: title,
                                                    style: .default,
                                                    handler: { (_) in
                                                        actionBlock()
            }))
        } else if let title = secondaryButtonTitle {
            alertController.addAction(UIAlertAction(title: title,
                                                    style: .default))
        }

        return alertController
    }
}
