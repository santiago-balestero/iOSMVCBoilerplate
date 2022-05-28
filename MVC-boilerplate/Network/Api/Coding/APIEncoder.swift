
import Foundation

class APIEncoder: JSONEncoder {

    override init() {
        super.init()

        keyEncodingStrategy = .convertToSnakeCase
        dateEncodingStrategy = .formatted(DateFormatter.apiFormat())
    }
}
