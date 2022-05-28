
import UIKit

class App {
    static let shared = App()

    var loggedUser: User? {
        didSet {
            UserDefaults.standard.setStruct(loggedUser, forKey: Constants.UserDefaultsKeys.loggedUser)
        }
    }

    var token: String? {
        didSet {
            UserDefaults.standard.set(token, forKey: Constants.UserDefaultsKeys.token)
        }
    }

    var isLoggedIn: Bool { return token != nil && loggedUser != nil }

    var deviceTokenData: Data? {
        didSet {
            guard let data = deviceTokenData else { return }
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultsKeys.deviceTokenData)
        }
    }

    var statusBarStyle: UIStatusBarStyle = .lightContent

    private init() {
        token = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.token)
        loggedUser = UserDefaults.standard.structData(User.self, forKey: Constants.UserDefaultsKeys.loggedUser)
        deviceTokenData = UserDefaults.standard.data(forKey: Constants.UserDefaultsKeys.deviceTokenData)
    }
}
