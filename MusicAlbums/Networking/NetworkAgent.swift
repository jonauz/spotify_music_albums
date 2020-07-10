//
//  NetworkAgent.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

struct NetworkAgent {

    func request<T: Decodable>(_ request: URLRequest, debug: Bool = false, successHanler: @escaping (T) -> Void, failHandler: @escaping (NetworkError) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if debug, let data = data {
                print("DEBUG :: \(request.httpMethod ?? "") \(request.url?.path ?? "") - data:", String(decoding: data, as: UTF8.self))
            }

            if let error = error {
                let responseError = NetworkError(type: .networkError, error: error, message: error.localizedDescription)
                DispatchQueue.main.async {
                    failHandler(responseError)
                }
                return
            }

            guard let httpURLResponse = response as? HTTPURLResponse else {
                let responseError = NetworkError(type: .badServerResponse)
                DispatchQueue.main.async {
                    failHandler(responseError)
                }
                return
            }

            guard httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 300 else {
                let responseError = NetworkError(type: .statusCode(httpURLResponse.statusCode))
                DispatchQueue.main.async {
                    failHandler(responseError)
                }
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let dataObject = data, let responseObject = try? decoder.decode(T.self, from: dataObject) else {
                let responseError = NetworkError(type: .invalidResponseData(data))
                DispatchQueue.main.async {
                    failHandler(responseError)
                }
                return
            }

            DispatchQueue.main.async {
                successHanler(responseObject)
            }
        }
        task.resume()
    }
}
