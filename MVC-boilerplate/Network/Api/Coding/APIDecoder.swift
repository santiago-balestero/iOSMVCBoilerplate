
import Foundation

class APIDecoder: JSONDecoder {

    override init() {
        super.init()

        keyDecodingStrategy = .convertFromSnakeCase
        dateDecodingStrategy = .formatted(DateFormatter.apiFormat())
    }
}
