
protocol UserApiClientProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, ApiError>) -> Void)

    func signUp(firstName: String, lastName: String, email: String, password: String,
                pictureURL: String?, completion: @escaping (Result<Void, ApiError>) -> Void)

    func fbSignIn(userId: String, accessToken: String, completion: @escaping (Result<Void, ApiError>) -> Void)

    func getAll(completion: @escaping (Result<[User], ApiError>) -> Void)
}
