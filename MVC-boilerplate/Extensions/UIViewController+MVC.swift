
import UIKit

extension UIViewController {
    func addBackgroundImage(imageName: String, size: CGSize, origin: CGPoint? = nil) {
        if let image = UIImage(named: imageName) {
            let frame = CGRect(origin: origin ?? UIScreen.main.bounds.origin, size: size)
            let backgroundImage = UIImageView(frame: frame)
            backgroundImage.image = image
            backgroundImage.contentMode =  .scaleAspectFill
            view.insertSubview(backgroundImage, at: 0)
        }
    }

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }

    static func topPresenter() -> UIViewController? {
        var currentVc = UIApplication.shared.rootViewController

        while let presented = currentVc?.presentedViewController {
            if let navVc = presented as? UINavigationController {
                currentVc = navVc
            } else if let tabVc = (presented as? UITabBarController)?.selectedViewController {
                currentVc = tabVc
            } else {
                break
            }
        }
        return currentVc
    }
}
