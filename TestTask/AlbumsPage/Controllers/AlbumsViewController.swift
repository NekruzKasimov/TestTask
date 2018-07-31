//
//  AlbumsViewController.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var albums = [Album]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        ServerManager.shared.getAlbums(completion: { (albums) in
            var shufledAlbums = albums
            shufledAlbums.shuffle()
            self.albums = Array(shufledAlbums.prefix(upTo: 10))
            self.collectionView.reloadData()
        }) { (message) in
            self.showErrorAlert(message: message)
        }
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 20) / 3
        let height = width
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        collectionView.collectionViewLayout = flowLayout
    }
}


// MARK: CollectionView Configuration
extension AlbumsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumsCollectionViewCell", for: indexPath) as! AlbumsCollectionViewCell
        cell.titleLabel.text = albums[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Albums", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImagesViewController") as! ImagesViewController
        vc.albumId = albums[indexPath.row].id
        self.navigationController?.show(vc, sender: self)
    }
}
