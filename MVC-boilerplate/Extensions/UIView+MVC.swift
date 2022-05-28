
import UIKit

extension UIView {
    func roundCorners(radius: CGFloat? = nil,
                      roundedCorners: CACornerMask? = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]) {
        clipsToBounds = true
        layer.cornerRadius = radius ?? 8.0
        layer.maskedCorners = roundedCorners ?? [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]

    }

    func borderLine(color: UIColor, width: CGFloat? = nil) {
        layer.borderWidth = width ?? 1.0
        layer.borderColor = color.cgColor
    }
}
