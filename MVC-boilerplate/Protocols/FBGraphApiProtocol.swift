
protocol FBGraphApiProtocol {
    func getProfile(completion: @escaping (Result<FBUserData, ApiError>) -> Void)
}
