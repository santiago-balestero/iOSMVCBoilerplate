
import Foundation
import Alamofire

class ApiRequestInterceptor: RequestInterceptor {

    let retryLimit = Constants.Server.retries
    let retryDelay: TimeInterval = Constants.Server.retryDelay

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = App.shared.token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: Constants.Server.Keys.Headers.authentication)
        }

        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
      let response = request.task?.response as? HTTPURLResponse
      //Retry for 5xx status codes
      if
        let statusCode = response?.statusCode,
        (500...599).contains(statusCode),
        request.retryCount < retryLimit {
          completion(.retryWithDelay(retryDelay))
      } else {
        return completion(.doNotRetry)
      }
    }
}
