
import Foundation

extension NSObject {

    class var className: String {
        return String(describing: self)
    }

    class var nibName: String {
        if let name = String(describing: self).components(separatedBy: ".").last {
            return name
        }
        return String(describing: self)
    }
}
