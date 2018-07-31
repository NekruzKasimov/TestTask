//
//  Constants.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation

class Constants {
    static let url = "https://jsonplaceholder.typicode.com"
    
    struct Api {
        static let posts = url + "/posts"
        static let comments = "/comments"
        static let albums = url + "/albums"
        static let weatherBishkek = "https://api.openweathermap.org/data/2.5/weather?lat=42.874722&lon=74.612222&APPID=079587841f01c6b277a82c1c7788a6c3"
        static let weatheOsh = "https://api.openweathermap.org/data/2.5/weather?lat=40.52828&lon=72.7985&APPID=079587841f01c6b277a82c1c7788a6c3"
        static let weatherNaryn = "https://api.openweathermap.org/data/2.5/weather?lat=41.42866&lon=75.99111&APPID=079587841f01c6b277a82c1c7788a6c3"
        static let weatherCholponAta = "https://api.openweathermap.org/data/2.5/weather?lat=42.64944&lon=77.08225&APPID=079587841f01c6b277a82c1c7788a6c3"
        static let photos = "/photos"
    }
}
