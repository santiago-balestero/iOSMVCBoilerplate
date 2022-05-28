
import UIKit

extension UIFont {
    struct Buttons {
        static let primary: UIFont = .semiBold(with: 20)
        static let secondary: UIFont = .semiBold(with: 20)
        static let showHide: UIFont = .semiBold(with: 12)
    }

    struct Onboarding {
        static let subtitle: UIFont = .bold(with: 45)
    }

    struct SignIn {
        static let subtitle: UIFont = .bold(with: 45)
    }

    struct InputFields {
        static let label: UIFont = .regular(with: 12)
        static let input: UIFont = .regular(with: 16)
        static let placeholder: UIFont = .regular(with: 16)
        static let error: UIFont = .regular(with: 10)
    }

    static func bold(with size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func regular(with size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Roman", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func light(with size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func semiBold(with size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
