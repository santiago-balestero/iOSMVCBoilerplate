
import Foundation

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let role: String
    let birthDate: Date
    let isVerified: Bool
    let technologies: [Technology]
    let fbId: String
}

struct Users: Decodable {
    let users: [User]
}
