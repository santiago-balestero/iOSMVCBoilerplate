
import UIKit

enum TabIndex: Int {
    case projects
    case team
    case company

    func title() -> String? {
        switch self {
        case .team: return localized("tab_bar_team")
        case .projects: return localized("tab_bar_projects")
        case .company: return localized("tab_bar_company")
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barStyle = .black
        tabBar.barTintColor = UIColor.TabBar.tint
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5))
        lineView.backgroundColor = UIColor.NavigationBar.shadow
        tabBar.addSubview(lineView)
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setTabIcons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !App.shared.isLoggedIn {
            performSegue(withIdentifier: "showOnboarding", sender: nil)
        }
    }

    // MARK: - Public Methods

    func showTab(tabIndex: TabIndex) {
        selectedIndex = tabIndex.rawValue
    }

    // MARK: - Private Methods
    private func image(for tabIndex: TabIndex, selected: Bool) -> UIImage? {
        switch tabIndex {
        case .team: return selected ? UIImage.TabBar.teamSelected : UIImage.TabBar.team
        case .projects: return selected ? UIImage.TabBar.projectsSelected : UIImage.TabBar.projects
        case .company: return selected ? UIImage.TabBar.companySelected : UIImage.TabBar.company
        }
    }

    private func setTabIcons() {
        guard let items = tabBar.items else {
            return
        }
        var index = 0
        for item in items {
            let tabIndex: TabIndex = TabIndex(rawValue: index) ?? .projects
            item.image = image(for: tabIndex, selected: false)
            item.selectedImage = image(for: tabIndex, selected: true)
            item.isAccessibilityElement = true
            item.title = tabIndex.title()
            item.tag = index
            index += 1
        }
    }

    // MARK: - UITabBarControllerDelegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
