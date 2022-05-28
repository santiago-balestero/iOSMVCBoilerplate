
import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {

    var basePath: String { get }

    // MARK: - Path
    var path: String { get }
    var headers: HTTPHeaders { get }

    // MARK: - Parameters
    var body: Parameters? { get }
    var query: Parameters? { get }

    // MARK: - Methods
    var method: HTTPMethod { get }
}

extension URLRequestBuilder {
    var headers: HTTPHeaders {
        var header = HTTPHeaders()

        header["Accept"] = "application/json"
        header["Content-Type"] = "application/json; charset=utf-8"

        return header
    }

    func asURLRequest() throws -> URLRequest {
        let url = try basePath.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        headers.forEach { header in request.setValue(header.value, forHTTPHeaderField: header.name) }
        request.timeoutInterval = TimeInterval(Constants.Server.timeout)

        if let params = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        }

        return request
    }

}
