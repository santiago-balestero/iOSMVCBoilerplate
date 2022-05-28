
import UIKit

class ViewController: UIViewController {

    var navigationBarColor: UIColor? {
        didSet {
            navigationController?.navigationBar.barTintColor = navigationBarColor
        }
    }

    var navigationBarTransluscent: Bool = false {
        didSet {
            if let navController = navigationController as? NavigationController {
                navController.transluscent = navigationBarTransluscent
                setBackButton()
            }
        }
    }

    var screenTitle: String? {
        didSet {
            navigationItem.title = screenTitle
        }
    }

    var screenName = ""
    var showBackButton = true
    var isVisible: Bool = false

    // MARK: - Status Bar methods
    var statusBarStyle: UIStatusBarStyle = App.shared.statusBarStyle {
        didSet {
            if let navController = navigationController as? NavigationController {
                navController.statusBarStyle = statusBarStyle
            } else {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTransluscent = false
        navigationItem.hidesBackButton = true
        setBackButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let navController = navigationController as? NavigationController,
            let top = navController.topViewController as? ViewController {

            navController.navigationBar.barTintColor = (top.navigationBarColor != nil) ? top.navigationBarColor : UIColor.NavigationBar.background
        }

        hideBackButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        isVisible = true
        Dialogs.shared.visibileViewController = self
        if screenName.isEmpty {
            print("WARNING Missing screen name for class \(String(describing: self))")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        isVisible = false
    }

    func setBackButton() {
        if let vcs = navigationController?.viewControllers.count, vcs > 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(back))
        } else if let nav = navigationController, nav.isBeingPresented, navigationItem.leftBarButtonItem == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(named: navigationBarTransluscent ? "closeDark" : "closeLight"),
                style: .plain,
                target: self,
                action: #selector(closeAll))
        }
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc func closeAll() {
        close()
    }

    @objc func close(completion: (() -> Void)? = nil) {
        if let nav = navigationController {
            nav.dismiss(animated: true, completion: completion)
        } else if let nav = presentingViewController as? NavigationController, let viewController = nav.presentedViewController {
            viewController.dismiss(animated: true) {
                nav.dismiss(animated: true, completion: completion)
            }
        }
    }

    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }

    private func hideBackButton() {
        if !showBackButton {
            navigationItem.leftBarButtonItem?.image = UIImage()
            navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
}
