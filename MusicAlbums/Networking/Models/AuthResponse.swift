//
//  AuthResponse.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

struct AuthResponse: Codable {

    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
}
