//
//  AlbumsViewModel.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import Foundation

class AlbumsViewModel {

    private var apiClient: APIClientProtocol

    var albums: [Album] = []

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func auth(authorized: VoidClosure?, faild: VoidClosure?) {
        apiClient.authorize(onSuccess: { (authResponse) in
            UserData.shared.accessToken = "\(authResponse.tokenType) \(authResponse.accessToken)"
            authorized?()
        }) { (error) in
            print("Network error:", error)
            faild?()
        }
    }

    func getNewlyReleasedAlbums(completion: @escaping VoidClosure) {
        guard UserData.shared.isAuthorized else {
            func continueAfterSuccesfulAuth() {
                getNewlyReleasedAlbums(completion: completion)
            }
            auth(authorized: continueAfterSuccesfulAuth, faild: nil)
            return
        }

        apiClient.accessToken = UserData.shared.accessToken

        apiClient.getNewlyReleasedAlbums(onSuccess: { [weak self] (albumsResponse) in
            print("Albums:", albumsResponse.albums.items)
            self?.albums.append(contentsOf: albumsResponse.albums.items)
            completion()
        }) { (error) in
            print("Network error:", error)
        }
    }
}
