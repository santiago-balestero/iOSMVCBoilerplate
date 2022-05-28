
import UIKit

enum ButtonStyle {
    case primary, secondary, facebook, google, apple, text

    var font: UIFont {
        return UIFont.Buttons.primary
    }

    var titleColor: UIColor {
        switch self {
        case .secondary, .text: return UIColor.Buttons.secondaryTitle
        case .apple: return UIColor.Social.apple
        case .facebook: return UIColor.Social.facebook
        case .google: return UIColor.Social.google
        default: return UIColor.Buttons.primaryTitle
        }
    }

    var bgdColor: UIColor {
        switch self {
        case .primary: return UIColor.Buttons.primaryBackground
        default: return UIColor.Buttons.secondaryBackground
        }
    }

    var borderColor: UIColor? {
        switch self {
        case .secondary: return UIColor.Buttons.secondaryTitle
        case .apple: return UIColor.Social.apple
        case .facebook: return UIColor.Social.facebook
        case .google: return UIColor.Social.google
        default: return nil
        }
    }

    var icon: UIImage? {
        switch self {
        case .apple: return UIImage(named: "apple_logo")
        case .facebook: return UIImage(named: "fb_logo")
        case .google: return UIImage(named: "google_logo")
        default: return nil
        }
    }
}

extension UIButton {
    func apply(style: ButtonStyle,
               title: String,
               borderColor: UIColor? = nil,
               specialRadius: CGFloat? = nil,
               borderWidth: CGFloat? = nil,
               font: UIFont? = nil) {

        roundCorners(radius: (frame.height - 4)/2)
        backgroundColor = style.bgdColor
        titleLabel?.font = style.font
        setTitleColor(color: style.titleColor)
        setTitle(title: title)

        if let border = style.borderColor {
            borderLine(color: border)
        }

        if let icon = style.icon {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
            setImage(image: icon)
        }

        if let font = font { titleLabel?.font = font }
        if let color = borderColor { borderLine(color: color, width: borderWidth)}
        if let radius = specialRadius { roundCorners(radius: radius) }
    }

    private func setTitleColor(color: UIColor) {
        setTitleColor(color, for: .normal)
        setTitleColor(color, for: .disabled)
        setTitleColor(color, for: .highlighted)
        setTitleColor(color, for: .selected)
    }

    func setTitle(title: String) {
        setTitle(title, for: .normal)
        setTitle(title, for: .disabled)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .selected)
    }

    private func setImage(image: UIImage) {
        setImage(image, for: .normal)
        setImage(image, for: .disabled)
        setImage(image, for: .highlighted)
        setImage(image, for: .selected)
    }
}
