
import UIKit
import SDWebImage
import AVFoundation

class SignUpViewController: ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var inputs: [FormTextField]!

    @IBOutlet weak var changeImage: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstName: FirstNameTextField!
    @IBOutlet weak var lastName: LastNameTextField!
    @IBOutlet weak var email: NewEmailTextField!
    @IBOutlet weak var password: NewPasswordTextField!
    @IBOutlet weak var signUp: UIButton!

    var imagePicker = UIImagePickerController()

    private var imageURL: String?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        screenName = Constants.ScreenNames.signUp
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationBarTransluscent = true
        statusBarStyle = .darkContent
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Action methods
    @IBAction func signUpAction(_ sender: Any) {
        guard let email = email.text,
              let firstName = firstName.text,
              let lastName = lastName.text,
              let password = password.text,
              validateAllFields() else {
            return
        }

        Dialogs.shared.showLoading()
        ApiClient.shared.userClient.signUp(firstName: firstName, lastName: lastName,
                             email: email, password: password,
                             pictureURL: imageURL) { (result) in
            switch result {
            case .success:
                Dialogs.shared.hideLoading()
                self.close()
            case .failure(let error): Dialogs.shared.showError(error: error)
            }
        }
    }

    @IBAction func changeImageAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: localized("profile_image_picker_title"),
                                            message: localized("profile_image_picker_message"),
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(
                                title: localized("take_photo_title"),
                                style: .default,
                                handler: { _ in
                                    self.openCamera()
                                }))
        actionSheet.addAction(UIAlertAction(
                                title: localized("pick_photo_title"),
                                style: .default,
                                handler: { _ in
                                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                                        self.imagePicker.delegate = self
                                        self.imagePicker.sourceType = .photoLibrary
                                        self.imagePicker.allowsEditing = false
                                        self.present(self.imagePicker, animated: true, completion: nil)
                                    }

                                }))
        actionSheet.addAction(UIAlertAction(title: localized("cancel"), style: .cancel))

        present(actionSheet, animated: true, completion: nil)
    }
    // MARK: - Private methods
    private func setUpUI() {
        //Generic UI
        signUp.apply(style: .primary,
                     title: localized("sign_up_button"))
        //Forms UI
        firstName.nextView = lastName
        lastName.nextView = email
        email.nextView = password
        profileImage.layer.masksToBounds = false
        profileImage.roundCorners(radius: profileImage.frame.height/2)
        profileImage.clipsToBounds = true
    }

    private func loadFBUserData(user: FBUserData?) {
        firstName.text = user?.firstName
        lastName.text = user?.lastName
        email.text = user?.email

        if let urlString = user?.profilePicture {
            profileImage.sd_setImage(with: URL(string: urlString), completed: nil)
        }
    }

    private func validateAllFields() -> Bool {
        for field in inputs {
            field.validate()
        }
        return inputs.allSatisfy({ (field) -> Bool in
            field.isValid()
        })
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
//           let compressData = pickedImage.jpegData(compressionQuality: 0.25) {
//            profileImage.contentMode = .scaleAspectFill
//            // upload to S3 bucket
//        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func checkCameraPermissions() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)))

        switch authStatus {
        case .authorized, .notDetermined: openCamera()
        default:
            // Not determined will fall here - after first use, when is't neither authorized, nor denied
            // we try to use camera, because system will ask itself for camera permissions
            alertPromptToAllowCameraAccessViaSetting()
        }
    }

    func openCamera() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType(
                                                    rawValue: convertFromAVMediaType(AVMediaType.video))) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                AVCaptureDevice.requestAccess(for: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)),
                                              completionHandler: { (granted: Bool) -> Void in
                    DispatchQueue.main.async {
                        if granted == true {
                            // User granted
                            self.present(self.imagePicker, animated: true, completion: nil)
                        } else {
                            // User Rejected
                            self.imagePicker.dismiss(animated: true, completion: nil)
                        }
                    }
                })
            }

        } else {
            Dialogs.shared.showError(message: localized("no_camera_available_error"))
        }
    }

    func alertPromptToAllowCameraAccessViaSetting() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            Dialogs.shared.showError(message: localized("no_camera_access_error"))
        } else {
            Dialogs.shared.showError(message: localized("no_camera_available_error"))
        }
    }

    fileprivate func convertFromAVMediaType(_ input: AVMediaType) -> String {
        return input.rawValue
    }
}
