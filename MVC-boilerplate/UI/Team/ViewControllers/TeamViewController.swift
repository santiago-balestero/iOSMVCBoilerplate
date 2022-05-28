
import Foundation
import UIKit

class TeamViewController: ViewController {

    @IBOutlet var tableView: UITableView!
    var team: [User]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        screenTitle = .title
        fetchTeam()
    }

    private func fetchTeam() {

    }
}

extension TeamViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.team?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCellIdentifier", for: indexPath) as? TeamCell,
            let user = team?[indexPath.row]
        else {
            fatalError("Unable to configure teams cells")
        }

        cell.configure(user: user)
        return cell
    }
}

fileprivate extension String {
    static let title = localized("team_title")
    static let error = localized("error")
    static let unexpectedError = localized("team_error")
}
