
import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        return windows.filter({$0.isKeyWindow}).first?.rootViewController
    }
}
