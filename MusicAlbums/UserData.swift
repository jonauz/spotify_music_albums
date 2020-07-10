//
//  UserData.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

class UserData {

    static let shared = UserData()

    var accessToken: String?

    var isAuthorized: Bool {
        return accessToken != nil
    }
}
