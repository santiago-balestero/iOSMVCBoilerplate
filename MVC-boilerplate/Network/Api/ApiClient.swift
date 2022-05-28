
import Alamofire

class ApiClient {
    static let shared = ApiClient()

    var userClient: UserApiClientProtocol
//    var fbClient: FBGraphApiProtocol

    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })

        let logger = ApiLogger()
        let interceptor = ApiRequestInterceptor()

        return Session(
          configuration: configuration,
          interceptor: interceptor,
          cachedResponseHandler: responseCacher,
          eventMonitors: [logger])
      }()

    private init() {
        // We can change this to use macros when adding tests
        userClient = UserApiClient()
//        fbClient = FBGraphClient()
    }

    func request<T: Decodable>(_ convertible: URLRequestConvertible,
                               decoder: JSONDecoder = APIDecoder(),
                               completion: @escaping (Result<T, ApiError>) -> Void) {
        session.request(convertible).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in

            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let err):
                do {
                    if let data = response.data {
                        print(String(decoding: data, as: UTF8.self))
                        let errorResponse = try decoder.decode(ApiErrorResponse.self, from: data)
                        completion(.failure(errorResponse.error))
                    } else if err.isResponseSerializationError {
                        completion(.failure(ApiError(code: .parsing, message: "There was a serialization issue" )))
                    } else {
                        completion(.failure(ApiError(code: .unexpected, message: nil)))
                    }
                } catch {
                    completion(.failure(ApiError(code: .unexpected, message: nil)))
                }
            }
        }
    }
}
