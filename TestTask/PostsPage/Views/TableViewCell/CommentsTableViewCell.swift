//
//  CommentsTableViewCell.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation
import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    var comment: Comment? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        guard let comment = comment else {
            return
        }
        self.selectionStyle = .none
        self.bodyLabel.text = comment.body
        self.emailLabel.text = comment.email
        self.nameLabel.text = comment.name
    }
}
