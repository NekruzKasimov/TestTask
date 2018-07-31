//
//  Photo.swift
//  TestTask
//
//  Created by Niko on 8/1/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var albumId: Int?
    var id: Int?
    var url: String?
    var title: String?
    var thumbnailUrl: String?
}
