//
//  Album.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 10/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

struct Album: Codable {

    let albumType: String
    let artists: [Album.AlbumArtist]
    //let available_markets: [AnyObject]
    let externalUrls: Album.AlbumExternalUrl
    let href: String
    let id: String
    var images: [Album.AlbumImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: String
    let label: String?
    let tracks: AlbumTrack?

    var largeImage: Album.AlbumImage? {
        if let tmpLargeImage = images.first, tmpLargeImage.width == 640 {
            return tmpLargeImage
        }
        return nil
    }

    struct AlbumArtist: Codable {
        let id: String
        let href: String
        let name: String
        let uri: String
        let type: String
    }

    struct AlbumExternalUrl: Codable {
        let spotify: String
    }

    struct AlbumImage: Codable {
        let url: String
        let height: Int
        let width: Int
    }

    struct AlbumTrack: Codable {
        let total: Int
    }
}
