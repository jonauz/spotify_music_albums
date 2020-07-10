//
//  AlbumsResponse.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

struct AlbumsResponse: Codable {

    struct Albums: Codable {

        let href: String
        let items: [Album]
        let limit: Int
        let next: String?
        let offset: Int
        let previous: String?
        let total: Int
    }

    let albums: Albums
}
