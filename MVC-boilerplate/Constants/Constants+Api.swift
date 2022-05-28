
import Foundation

extension Constants {
    struct Server {
        #if STAGE
        static let host = "http://boilerplateapi-env.eba-paijgmrm.us-east-1.elasticbeanstalk.com"
        #elseif DEV
        static let host = "http://boilerplateapi-env.eba-paijgmrm.us-east-1.elasticbeanstalk.com"
        #else
        static let host = ""
        #endif

        struct Keys {
            struct Body {
                static let email = "email"
                static let password = "password"
                static let firstName = "first_name"
                static let lastName = "last_name"
                static let accessToken = "access_token"
                static let fbId = "fb_id"
                static let pictureURL = "picture_url"
            }

            struct Headers {
                static let authentication: String = "authentication"
            }

            struct Query {

            }
        }

        static let timeout = 60
        static let retries = 2
        static let retryDelay: TimeInterval = 10
        static let apiRootPath = "/api"
        static let usersBasePath = "\(apiRootPath)/users"
    }
}
