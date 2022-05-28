
import Foundation
import UIKit

class TeamCell: UITableViewCell {

    var user: User?
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var customContentView: UIView!

    func configure(user: User) {
        self.user = user
        self.userNameLabel.text = "\(user.firstName) \(user.lastName) (\(user.birthDate.prettyToString()))"
        self.userEmailLabel.text = user.email

        customContentView.layer.cornerRadius = 6.0
        customContentView.layer.borderWidth = 0.0
        customContentView.layer.shadowColor = UIColor.lightGray.cgColor
        customContentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        customContentView.layer.shadowRadius = 6.0
        customContentView.layer.shadowOpacity = 1
    }
}
