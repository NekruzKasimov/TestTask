//
//  ImagesViewController.swift
//  TestTask
//
//  Created by Niko on 8/1/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [Photo]()
    var albumId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Images"
        ServerManager.shared.getImages(by: albumId!, completion: { (photos) in
            self.photos = photos
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
extension ImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        cell.url = photos[indexPath.row].thumbnailUrl
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Albums", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailedImageViewController") as! DetailedImageViewController
        vc.photo = photos[indexPath.row]
        self.navigationController?.show(vc, sender: self)
    }
    
}
