
import Alamofire

struct UserApiClient: UserApiClientProtocol {

    func login(email: String, password: String, completion: @escaping (Result<Void, ApiError>) -> Void) {
        let credentials = [
            Constants.Server.Keys.Body.email: email,
            Constants.Server.Keys.Body.password: password
        ]

        ApiClient.shared.request(UserRouter.login(credentials)) { (result: Result<Authentication, ApiError>) in

            switch result {
            case .success(let response):
                App.shared.loggedUser = response.user
                App.shared.token = response.accessToken

                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func signUp(firstName: String, lastName: String, email: String, password: String,
                pictureURL: String?, completion: @escaping (Result<Void, ApiError>) -> Void) {
        var data = [
            Constants.Server.Keys.Body.email: email,
            Constants.Server.Keys.Body.firstName: firstName,
            Constants.Server.Keys.Body.lastName: lastName,
            Constants.Server.Keys.Body.password: password
        ]

        if let urlString = pictureURL {
            data[Constants.Server.Keys.Body.lastName] = urlString
        }
        ApiClient.shared.request(UserRouter.signUp(data)) { (result: Result<Authentication, ApiError>) in
            switch result {
            case .success(let response):
                App.shared.loggedUser = response.user
                App.shared.token = response.accessToken
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fbSignIn(userId: String, accessToken: String, completion: @escaping (Result<Void, ApiError>) -> Void) {
        let data: Parameters = [
            Constants.Server.Keys.Body.fbId: userId,
            Constants.Server.Keys.Body.accessToken: accessToken
        ]

        ApiClient.shared.request(UserRouter.fbSignIn(data)) { (result: Result<FBAuthentication, ApiError>) in
            switch result {
            case .success(let response):
                if let user = response.user, let token = response.accessToken {
                    App.shared.loggedUser = user
                    App.shared.token = token
                }

                completion(.success(()))
            case .failure(let error): completion(.failure(error))
            }
        }
    }

    func getAll(completion: @escaping (Result<[User], ApiError>) -> Void) {
        ApiClient.shared.request(UserRouter.find(nil)) { (result: Result<Users, ApiError>) in
            switch result {
            case .success(let response):
                completion(.success(response.users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
