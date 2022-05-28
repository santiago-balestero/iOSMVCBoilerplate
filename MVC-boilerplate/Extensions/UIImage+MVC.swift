
import UIKit

extension UIImage {

    struct TabBar {
        static let team = image(name: "team").withTintColor(UIColor.TabBar.itemOff)
        static let teamSelected = image(name: "team").withTintColor(UIColor.TabBar.itemOn)
        static let projects = image(name: "projects").withTintColor(UIColor.TabBar.itemOff)
        static let projectsSelected = image(name: "projects").withTintColor(UIColor.TabBar.itemOn)
        static let company = image(name: "company").withTintColor(UIColor.TabBar.itemOff)
        static let companySelected = image(name: "company").withTintColor(UIColor.TabBar.itemOn)
    }

    static func image(name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }
}
