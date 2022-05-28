
import UIKit

class SignInViewController: ViewController {

    @IBOutlet var inputs: [FormTextField]!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var emailField: EmailTextField!
    @IBOutlet weak var passwordField: PasswordTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        screenName = Constants.ScreenNames.signIn
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationBarTransluscent = true
        statusBarStyle = .darkContent
    }

    // MARK: - Private methods
    private func setUI() {
        emailField.nextView = passwordField
        emailField.placeholder = localized("sign_in_email_placeholder")
        passwordField.placeholder = localized("sign_in_password_placeholder")
        subtitle.font = UIFont.SignIn.subtitle
        subtitle.textColor = UIColor.SignIn.subtitle
        subtitle.text = localized("sign_in_title")

        logInButton.apply(style: .primary,
                          title: localized("sign_in_button"),
                          specialRadius: 24)

        forgotPasswordButton.apply(style: .text,
                                   title: localized("forgot_password_button"))
    }

    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text, validateAllFields() else { return }

        Dialogs.shared.showLoading()
        ApiClient.shared.userClient.login(
            email: email,
            password: password) { (result) in
            switch result {
            case .success:
                Dialogs.shared.hideLoading()
                self.close()
            case .failure(let error): Dialogs.shared.showError(error: error)
            }
        }
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
    }

    // MARK: - Private methods

    private func validateAllFields() -> Bool {
        for field in inputs {
            field.validate()
        }
        return inputs.allSatisfy({ (field) -> Bool in
            field.isValid()
        })
    }
}
