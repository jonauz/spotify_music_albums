//
//  APIClient.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

protocol APIClientProtocol {

    var accessToken: String? { get set }

    var debug: Bool { get set }

    init()

    func authorize(onSuccess: @escaping (AuthResponse) -> Void, onError: @escaping (NetworkError) -> Void)

    func getNewlyReleasedAlbums(onSuccess: @escaping (AlbumsResponse) -> Void, onError: @escaping (NetworkError) -> Void)

    func getAlbumDetails(id: String, onSuccess: @escaping (Album) -> Void, onError: @escaping (NetworkError) -> Void)
}

struct APIClient: APIClientProtocol {

    static let agent = NetworkAgent()
    static let authBase = URL(string: "https://accounts.spotify.com")!
    static let base = URL(string: "https://api.spotify.com")!
    var accessToken: String?
    var debug: Bool = false
    init() {}

    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"

        var value: String {
            return self.rawValue
        }
    }
}

extension APIClient {

    func authorize(onSuccess: @escaping (AuthResponse) -> Void, onError: @escaping (NetworkError) -> Void) {
        var request = URLRequest(url: Self.authBase.appendingPathComponent("/api/token"))
        request.httpMethod = "POST"
        request.addValue(ClientAuthKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var bodyComponents = URLComponents()
        bodyComponents.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        request.httpBody = bodyComponents.query?.data(using: .utf8)
        Self.agent.request(request, debug: debug, successHanler: onSuccess, failHandler: onError)
    }

    func getNewlyReleasedAlbums(onSuccess: @escaping (AlbumsResponse) -> Void, onError: @escaping (NetworkError) -> Void) {
        guard let accessToken = accessToken else {
            onError(NetworkError(type: .unauthorized))
            return
        }
        let request = Self.getURLRequest(url: "/v1/browse/new-releases", accessToken: accessToken)
        Self.agent.request(request, debug: debug, successHanler: onSuccess, failHandler: onError)
    }

    func getAlbumDetails(id: String, onSuccess: @escaping (Album) -> Void, onError: @escaping (NetworkError) -> Void) {
        guard let accessToken = accessToken else {
            onError(NetworkError(type: .unauthorized))
            return
        }
        let request = Self.getURLRequest(url: "/v1/albums/\(id)", accessToken: accessToken)
        Self.agent.request(request, debug: debug, successHanler: onSuccess, failHandler: onError)
    }

    static func getURLRequest(url urlString: String, accessToken: String, params: [QueryParamsPair] = [], method: Method = .get, body: [StringLiteralType: Any]? = nil) -> URLRequest {
        var request = URLRequest(url: base.appendingPathComponent(urlString).appendingPathQueryParams(params))
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        if let body = body, let data = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) {
            request.httpBody = data
        }
        return request
    }
}

extension URL {
    func appendingPathQueryParams(_ params: [QueryParamsPair]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        urlComponents.queryItems = params.reduce([]) { (result, paramsPair) -> [URLQueryItem] in
            return result + [URLQueryItem(name: paramsPair.key, value: paramsPair.value)]
        }
        return urlComponents.url!
    }
}
