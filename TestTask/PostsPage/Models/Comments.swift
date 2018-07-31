//
//  Comments.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
}
