
import GoogleSignIn
import AuthenticationServices

class OnboardingViewController: ViewController, GIDSignInDelegate,
                                ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var apple: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var termsAndConditions: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var subtitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        screenName = Constants.ScreenNames.onboarding
        setUI()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationBarTransluscent = true
        statusBarStyle = .default
    }

    // MARK: - Private methods
    private func setUI() {
        signUp.apply(style: .primary,
                           title: localized("register_button_title"))
        apple.apply(style: .apple,
                          title: localized("apple_sign_in_button_title"))
        facebook.apply(style: .facebook,
                             title: localized("facebook_sign_in_button_title"))
        google.apply(style: .google,
                           title: localized("google_sign_in_button_title"))

        login.apply(style: .text, title: localized("sign_in_button_title"))

        termsAndConditions.isUserInteractionEnabled = true
        termsAndConditions.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(termsTapped(gesture:))))
        container.roundCorners(radius: 24)
        container.backgroundColor = UIColor.Onboarding.containerBackground
        subtitle.text = localized("onboarding_subtitle")
        subtitle.textColor = UIColor.Onboarding.subtitle
        subtitle.font = UIFont.Onboarding.subtitle
    }

    // MARK: - Action methods
    @IBAction func termsTapped(gesture: UITapGestureRecognizer) {
    }

    override func close(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func signInWithFacebookAction(_ sender: Any) {
   
    }

    @IBAction func signInWithGoogleAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }

    @IBAction func signInWithAppleAction(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()

        // request full name and email from the user's Apple ID
        request.requestedScopes = [.fullName, .email]

        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self

        // show the Sign-in with Apple dialog
        authController.performRequests()
    }


    // MARK: - Google methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    }

    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        navigationController?.present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    // MARK: Apple Sign in Methods
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        guard let error = error as? ASAuthorizationError else { return }
        switch error.code {
        case .unknown: break
        case .invalidResponse:
            // invalid response received from the login
            break
        case .notHandled:
            // authorization request not handled, maybe internet failure during login
            break
        case .failed:
            // authorization failed
            break
        default:
            return
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        
//        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
//              let code = appleIDCredential.authorizationCode else { return }
//        
//        let userID = appleIDCredential.user
//        let authorizationCode = String(decoding: code, as: Unicode.ASCII.self)
    }
}
