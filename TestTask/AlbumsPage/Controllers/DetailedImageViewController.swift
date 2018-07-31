//
//  DetailedImageViewController.swift
//  TestTask
//
//  Created by Niko on 8/1/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import UIKit
import Kingfisher

class DetailedImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = photo?.title
        let url = URL(string: (photo?.url)!)
        self.imageView.kf.setImage(with: url)
    }
}
