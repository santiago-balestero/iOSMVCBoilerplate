
enum ApiErrorCode: Int, Decodable {
    case badRequest = 400,
    unauthorized = 401,
    forbidden = 403,
    notFound = 404,
    parsing = 406,
    internalServer = 500,
    unexpected = 999

    var defaultMessage: String {
        switch self {
        case .notFound: return localized("not_found_error")
        case .badRequest: return localized("bar_request_error")
        case .unauthorized: return localized("unauthorized_error")
        case .forbidden: return localized("forbidden_error")
        case .parsing: return localized("parsing_error")
        case .internalServer: return localized("internal_server_error")
        default: return localized("unknown_error")
        }
    }
}

struct ApiError: Error, Decodable {
    let code: ApiErrorCode
    private let message: String?

    public init(code: ApiErrorCode, message: String?) {
        self.code = code
        self.message = message
    }

    func errorMessage() -> String {
        if let custom = message {
            return custom
        }

        return code.defaultMessage
    }
}

struct ApiErrorResponse: Decodable {
    var error: ApiError
}
