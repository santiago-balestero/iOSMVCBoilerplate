
import Foundation
import UIKit

class Dialogs: NSObject {
    static let shared = Dialogs()

    private var loadingViewController: LoadingViewController
    private var alertController: UIAlertController?
    private var loadingCount = 0
    private var errors: [ApiError] = []

    var isLoading: Bool {
        return visibileViewController?.isKind(of: LoadingViewController.self) ?? false
    }

    var visibileViewController: ViewController?

    override init() {
        loadingViewController = LoadingViewController(nibName: LoadingViewController.className, bundle: nil)
        loadingViewController.modalPresentationStyle = .overFullScreen
    }

    // MARK: - Loading methods
    func showLoading(description: String? = nil) {
        loadingCount += 1

        if !isLoading {
            if let presenter = UIViewController.topPresenter(), !presenter.isKind(of: LoadingViewController.self) {
                presenter.present(self.loadingViewController, animated: false) { }
            }
        }
    }

    func hideLoading() {
        if loadingCount > 0 {
            loadingCount -= 1

            if loadingCount == 0 {
                loadingViewController.dismiss(animated: false) {
                    if let error = self.errors.first {
                        self.showError(error: error)
                    }
                }
            }
        }
    }

    // MARK: - Errors methods
    func showError(error: ApiError) {
        hideLoading()

        if loadingCount == 0 {
            if !errors.isEmpty {
                errors.removeAll(where: { $0.code == error.code})
            }

            showErrorAlert(title: localized("default_error_title"), message: error.errorMessage())
        } else {
            errors.append(error)
        }
    }

    func showError(title: String? = nil, message: String) {
        hideLoading()

        if loadingCount == 0 {
            showErrorAlert(title: title ?? localized("default_error_title"), message: message)
        }
    }

    // MARK: - Private methods
    private func showErrorAlert(title: String, message: String) {

        let alert = UIAlertController.alert(title: localized("default_error_title"),
                                            message: message,
                                            primaryButtonTitle: localized("ok"),
                                            primaryButtonAction: {
                                            })
        UIViewController.topPresenter()?.present(alert, animated: false, completion: nil)
    }
}
