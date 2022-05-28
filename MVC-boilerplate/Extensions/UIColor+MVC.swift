
import UIKit

extension UIColor {
    struct Launch {
        static let background: UIColor = .black
        static let title: UIColor = Pallette.whiteCDS
    }

    struct NavigationBar {
        static let background = Pallette.blueCDS
        static let title = Pallette.whiteCDS
        static let shadow = Pallette.whiteCDS
    }

    struct TabBar {
        static let tint = UIColor.black
        static let itemOn = Pallette.blueCDS
        static let itemOff = Pallette.whiteCDS
    }

    struct Onboarding {
        static let containerBackground = Pallette.grayCDS
        static let subtitle = Pallette.blueCDS
    }

    struct SignIn {
        static let subtitle = Pallette.blueCDS
    }

    struct Buttons {
        static let primaryTitle = UIColor.white
        static let primaryBackground = Pallette.blueCDS
        static let secondaryTitle = Pallette.blueCDS
        static let secondaryBackground = UIColor.white
        static let showHideTitle = UIColor.white
        static let showHideBackground = Pallette.grayCDS
    }

    struct Social {
        static let facebook = Pallette.facebook
        static let google = Pallette.google
        static let apple = UIColor.black
    }

    struct InputFields {
        static let roundedBackground: UIColor = .white
        static let defaultBackground: UIColor = .clear
        static let label: UIColor = Pallette.blueCDS
        static let input: UIColor = Pallette.blueCDS
        static let message: UIColor = .black
        static let error: UIColor = UIColor.red
        static let placeholder: UIColor = Pallette.grayCDS
        static let border: UIColor = .black
        static let labelDisabled: UIColor = Pallette.blueCDS.withAlphaComponent(0.25)
        static let placeholderDisabled: UIColor = Pallette.blueCDS.withAlphaComponent(0.25)
        static let borderDisabled: UIColor = Pallette.blueCDS.withAlphaComponent(0.25)
        static let focusLabel: UIColor = Pallette.blueCDS
        static let focusText: UIColor = Pallette.blueCDS
        static let focusBorder: UIColor = Pallette.blueCDS
    }

    struct Dialogs {
        static let loadingBackground: UIColor = UIColor.black.withAlphaComponent(0.4)
        static let activityIndicator: UIColor = .white
    }
}
