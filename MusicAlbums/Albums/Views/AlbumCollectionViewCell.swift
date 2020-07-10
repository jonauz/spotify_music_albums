//
//  AlbumCollectionViewCell.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var authorLabel: UILabel = {
        let view = UILabel(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()

    lazy var releaseDateLabel: UILabel = {
        let view = UILabel(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 15)
        return view
    }()

    lazy var shareButton: UIButton = {
        let view = UIButton(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "share-100"), for: .normal)
        view.layer.cornerRadius = 5
        view.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        view.addTarget(self, action: #selector(share), for: .touchUpInside)
        return view
    }()

    var data: Album? {
        didSet {
            guard let data = data else { return }
            fetchImage(imageUrl: data.largeImage?.url)
            authorLabel.text = data.name
            releaseDateLabel.text = data.releaseDate
        }
    }

    var shareHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(shareButton)
        setNeedsUpdateConstraints()
    }

    func fetchImage(imageUrl: String?) {
        guard let imageUrl = imageUrl, imageUrl.count > 0 else { return }
        let url = URL(string: imageUrl)!

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = image
            }
        }.resume()
    }

    @objc func share() {
        shareHandler?()
    }

    override func updateConstraints() {
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true

        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        authorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true

        releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        releaseDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 0).isActive = true

        shareButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        super.updateConstraints()
    }
}
