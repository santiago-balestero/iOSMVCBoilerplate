
import Foundation

extension String {
    // MARK: - Validators

    func isBlank() -> Bool {
        return trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }

    func isValidEmail() -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    func isValidZipCode() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9]*[\\s\\-]?[a-zA-Z0-9]*$")
            .evaluate(with: self.uppercased().trimmingCharacters(in: .whitespacesAndNewlines))
    }

    func isValidPassword() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[0-9])(?=\\S+$).{6,}$")
            .evaluate(with: self)
    }

    func isValidName() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[a-z|A-Z]+(?: [a-z|A-Z]+)*$")
            .evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
