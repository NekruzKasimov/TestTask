//
//  ImagesCollectionViewCell.swift
//  TestTask
//
//  Created by Niko on 8/1/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import UIKit
import Kingfisher

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var url: String? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        guard let url = url else {
            return
        }
        let a = URL(string: url)
        imageView.kf.setImage(with: a)
    }
}
