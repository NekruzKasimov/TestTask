//
//  Models.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation

class Weather: Decodable {
    var name: String?
    var main: Main?
}

class Main: Decodable {
    var temp: Int?
    
    
    private enum CodingKeys : String, CodingKey {
        case temp = "temp"
    }

    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let t = try container.decode(Float.self, forKey: .temp) - 273.00
        temp = Int(t)
    }
}
