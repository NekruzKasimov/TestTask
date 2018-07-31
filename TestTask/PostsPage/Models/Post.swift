//
//  Post.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation

struct Post: Codable {
    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
}
