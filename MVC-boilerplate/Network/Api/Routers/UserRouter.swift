
import Alamofire

enum UserRouter: URLRequestBuilder {

    case login(Parameters),
         signUp(Parameters),
         create(Parameters),
         fbSignIn(Parameters),
         find(Parameters?)

    var basePath: String {
      return "\(Constants.Server.host)\(Constants.Server.usersBasePath)"
    }

    var method: HTTPMethod {
        switch self {
        case .login, .signUp, .create, .fbSignIn: return .post
        case .find: return .get
        }
    }

    var path: String {
        switch self {
        case .login: return "/login"
        case .signUp: return "/signUp"
        case .fbSignIn: return "/fb-sign-in"
        default: return ""
        }
    }

    var body: Parameters? {
        switch self {
        case .login(let body),
             .signUp(let body),
             .create(let body),
             .fbSignIn(let body): return body
        default: return nil
        }
    }

    var query: Parameters? {
        switch self {
        case .find(let query): return query
        default: return nil
        }
    }
}
