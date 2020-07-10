//
//  NetworkError.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

struct NetworkError {

    enum ErrorType: Error {
        case unauthorized
        case networkError
        case badServerResponse
        case statusCode(Int)
        case invalidResponseData(Data?)
    }

    let type: ErrorType
    let error: Error?
    let message: String?

    init(type: ErrorType, error: Error? = nil, message: String? = nil) {
        self.type = type
        self.error = error
        self.message = message
    }
}
