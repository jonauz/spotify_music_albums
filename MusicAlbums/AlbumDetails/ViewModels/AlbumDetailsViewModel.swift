//
//  AlbumDetailsViewModel.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 10/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

class AlbumDetailsViewModel {

    let id: String
    let albumName: String
    private var apiClient: APIClientProtocol

    var album: Album?

    var albumImage: String? {
        return album?.largeImage?.url
    }

    var artists: String {
        var result: [String] = []
        album?.artists.forEach({ result.append($0.name) })
        return result.joined(separator: ", ")
    }

    var releaseDate: String {
        return album?.releaseDate ?? ""
    }

    var label: String {
        if let albumLabel = album?.label {
        return "Label: \(albumLabel)"
        }
        return ""
    }

    var trackCount: String {
        if let totalTrackCount = album?.tracks?.total {
            return "Tracks count: \(totalTrackCount)"
        }
        return ""
    }

    init(id: String, albumName: String, apiClient: APIClientProtocol = APIClient()) {
        self.id = id
        self.albumName = albumName
        self.apiClient = apiClient
    }

    func getAlbumDetails(completion: @escaping VoidClosure) {
        guard UserData.shared.isAuthorized else { return }
        apiClient.accessToken = UserData.shared.accessToken
        apiClient.getAlbumDetails(id: id, onSuccess: { [weak self] (album) in
            self?.album = album
            completion()
        }) { (error) in
            print("Network error:", error)
        }
    }
}
