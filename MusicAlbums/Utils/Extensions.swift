//
//  Extensions.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import UIKit

extension CGRect {

    static var defaultRect: CGRect {
        return CGRect(x: 0, y: 0, width: 40, height: 10)
    }
}

extension UIImageView {
    func downloadImage(imageUrl: String?) {
        guard let imageUrl = imageUrl, imageUrl.count > 0 else { return }
        let imageId = imageUrl
        let url = URL(string: imageUrl)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                if imageUrl == imageId {
                    self.image = image
                }
            }
        }.resume()
    }
}
