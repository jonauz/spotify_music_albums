//
//  AlbumsViewController.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController, UICollectionViewDataSource {

    lazy var collectionView: UICollectionView = {
        let frame = CGRect.defaultRect
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width - 10, height: self.view.frame.width - 10 + 50)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let view = UICollectionView(frame: CGRect.defaultRect, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "albumCellIdentifier")
        view.dataSource = self
        //view.delegate = self
        return view
    }()

    var viewModel = AlbumsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.setNeedsUpdateConstraints()

        viewModel.getNewlyReleasedAlbums { [weak self] in
            // TODO
            self?.collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albums.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCellIdentifier", for: indexPath) as! AlbumCollectionViewCell
        cell.data = viewModel.albums[indexPath.item]
        cell.shareHandler = { [weak self] in
            self?.share(index: indexPath.item)
        }
        return cell
    }

    func share(index: Int) {
        let items = [URL(string: viewModel.albums[index].externalUrls.spotify)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }

    override func updateViewConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        super.updateViewConstraints()
    }
}
