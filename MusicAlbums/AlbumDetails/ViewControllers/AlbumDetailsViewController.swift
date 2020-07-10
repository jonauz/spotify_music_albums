//
//  AlbumDetailsViewController.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 10/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var authorLabel: UILabel = {
        let view = UILabel(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()

    lazy var releaseDateLabel: UILabel = {
        let view = UILabel(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        return view
    }()

    lazy var albumLabelsLabel: UILabel = {
        let view = UILabel(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        return view
    }()

    lazy var trackCountLabel: UILabel = {
        let view = UILabel(frame: CGRect.defaultRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        return view
    }()

    var viewModel: AlbumDetailsViewModel

    init(viewModel: AlbumDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(viewModel.albumName)"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(authorLabel)
        scrollView.addSubview(releaseDateLabel)
        scrollView.addSubview(albumLabelsLabel)
        scrollView.addSubview(trackCountLabel)
        view.setNeedsUpdateConstraints()
        scrollView.setNeedsUpdateConstraints()

        viewModel.getAlbumDetails { [weak self] in
            self?.updateViewsData()
        }
    }

    func updateViewsData() {
        imageView.downloadImage(imageUrl: viewModel.albumImage)
        authorLabel.text = viewModel.artists
        releaseDateLabel.text = viewModel.releaseDate
        albumLabelsLabel.text = viewModel.label
        trackCountLabel.text = viewModel.trackCount
    }

    override func updateViewConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true

        authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        authorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 10).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true

        releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        releaseDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 10).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 0).isActive = true

        albumLabelsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        albumLabelsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        albumLabelsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 10).isActive = true
        albumLabelsLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        albumLabelsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 0).isActive = true

        trackCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        trackCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        trackCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 10).isActive = true
        trackCountLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        trackCountLabel.topAnchor.constraint(equalTo: albumLabelsLabel.bottomAnchor, constant: 0).isActive = true

        super.updateViewConstraints()
    }
}
