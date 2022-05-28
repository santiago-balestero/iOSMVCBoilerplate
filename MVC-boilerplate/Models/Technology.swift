
import Foundation

struct Technology: Codable {
    let id: String
    let environment: String
    let language: String
    let family: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case environment
        case language
        case family
    }
}
