
import UIKit

class LoadingViewController: ViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Dialogs.loadingBackground
        activityIndicator.color = UIColor.Dialogs.activityIndicator
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        activityIndicator.startAnimating()
    }
}
