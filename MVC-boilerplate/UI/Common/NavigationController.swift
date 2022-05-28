
import UIKit

class NavigationController: UINavigationController {

    var statusBarStyle: UIStatusBarStyle = App.shared.statusBarStyle {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }

    var transluscent: Bool = false {
        didSet {
            navigationBar.isTranslucent = transluscent

            if transluscent {
                navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationBar.shadowImage = UIImage()
                view.backgroundColor = .clear
            }
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false

        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.NavigationBar.title
        ]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}
