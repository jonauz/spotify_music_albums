//
//  AlbumsResponse.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

struct AlbumsResponse: Codable {

    let albums: Albums

    struct Albums: Codable {
        let href: String
        let items: [Album]
    }
}
