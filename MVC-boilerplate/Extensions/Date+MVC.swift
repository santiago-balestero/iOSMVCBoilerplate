
import Foundation

extension Date {
    func prettyToString() -> String {
        return DateFormatter.prettyFormat().string(from: self)
    }
}
