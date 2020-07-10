//
//  MusicAlbumsTests.swift
//  MusicAlbumsTests
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import XCTest
@testable import Music_Albums

class MusicAlbumsTests: XCTestCase {

    var albumsViewModel: AlbumsViewModel?

    override func setUpWithError() throws {
        UserData.shared.accessToken = "some_access_token"
        let mockAPIClient = MockAPIClient()
        albumsViewModel = AlbumsViewModel(apiClient: mockAPIClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewlyReleasedAlbums() throws {
        let expectation = self.expectation(description: "Getting Newly Released Albums")

        albumsViewModel?.getNewlyReleasedAlbums(completion: {
            expectation.fulfill()
        })

        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                print("TEST FAIL :: \(#function) - error:", error)
                return
            }
            if let albumsViewModel = self.albumsViewModel {
                print("TEST :: new album count:", albumsViewModel.albums.count > 0)
            }
        }

        guard let album = albumsViewModel?.albums.first else {
            XCTFail("Failed to return at least one album")
            return
        }

        XCTAssertEqual(album.name, "name")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

struct MockAPIClient: APIClientProtocol {
    static let agent = NetworkAgent()
    static let base = URL(string: "https://test.com")!
    var accessToken: String?
    var debug: Bool = false
    init() {}
}

extension MockAPIClient {

    func authorize(onSuccess: @escaping (AuthResponse) -> Void, onError: @escaping (NetworkError) -> Void) {
        print("MockAPIClient ::", #function)
    }

    func getNewlyReleasedAlbums(onSuccess: @escaping (AlbumsResponse) -> Void, onError: @escaping (NetworkError) -> Void) {
        print("MockAPIClient ::", #function)
        let mockAlbum = Album(id: "id", name: "name", albumType: "albumType", artists: [], externalUrls: Album.AlbumExternalUrl(spotify: "spotify_link"), href: "href", images: [], releaseDate: "releaseDate", totalTracks: 1, label: "label", tracks: nil)
        let mockAlbums = AlbumsResponse.Albums(href: "album_link", items: [mockAlbum])
        let mockResult = AlbumsResponse(albums: mockAlbums)
        print(mockAlbums)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onSuccess(mockResult)
        }
    }

    func getAlbumDetails(id: String, onSuccess: @escaping (Album) -> Void, onError: @escaping (NetworkError) -> Void) {
        print("MockAPIClient ::", #function)
    }
}
