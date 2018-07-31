//
//  ServerManager.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation

class ServerManager: HTTPRequestManager {
    typealias WeatherHandler = (Weather?, String?) -> Void
    
    static let shared = ServerManager()
    
    func getPosts(completion: @escaping ([Post]) -> Void,
                  error:  @escaping (String) -> Void){
        self.get(api: Constants.Api.posts, completion: { (data) in
            let posts = try JSONDecoder().decode([Post].self, from: data)
            completion(posts)
        }) { (message) in
            error(message)
        }
    }
    
    func getComments(by postId: Int,
                     completion: @escaping ([Comment]) -> Void,
                     error:  @escaping (String) -> Void){
        let api = Constants.Api.posts + "/\(postId)" + Constants.Api.comments
        self.get(api: api, completion: { (data) in
            let comments = try JSONDecoder().decode([Comment].self, from: data)
            completion(comments)
        }) { (message) in
            error(message)
        }
    }
    
    func getWeather(completion: @escaping ([Weather]) -> Void,
                    error: @escaping (String) -> Void){
        var weather = [Weather]()
        self.get(api: Constants.Api.weatherBishkek, completion: { (data) in
            let bishkek = try JSONDecoder().decode(Weather.self, from: data)
            weather.append(bishkek)
            if weather.count == 4 {
                completion(weather)
            }
        }) { (message) in
            error(message)
        }
        self.get(api: Constants.Api.weatherNaryn, completion: { (data) in
            let naryn = try JSONDecoder().decode(Weather.self, from: data)
            weather.append(naryn)
            if weather.count == 4 {
                completion(weather)
            }
        }) { (message) in
            error(message)
        }
        self.get(api: Constants.Api.weatheOsh, completion: { (data) in
            let osh = try JSONDecoder().decode(Weather.self, from: data)
            weather.append(osh)
            if weather.count == 4 {
                completion(weather)
            }
        }) { (message) in
            error(message)
        }
        self.get(api: Constants.Api.weatherCholponAta, completion: { (data) in
            let cholponAta = try JSONDecoder().decode(Weather.self, from: data)
            weather.append(cholponAta)
            if weather.count == 4 {
                completion(weather)
            }
        }) { (message) in
            error(message)
        }
    }
    
    func getAlbums(completion: @escaping ([Album]) -> Void,
                   error: @escaping (String) -> Void){
        self.get(api: Constants.Api.albums, completion: { (data) in
            let albums = try JSONDecoder().decode([Album].self, from: data)
            completion(albums)
        }) { (message) in
            error(message)
        }
    }
    
    func getImages(by albumId: Int,
                   completion: @escaping ([Photo]) -> Void,
                   error: @escaping (String) -> Void) {
        let api = Constants.Api.albums + "/\(albumId)" + Constants.Api.photos
        self.get(api: api, completion: { (data) in
            let photos = try JSONDecoder().decode([Photo].self, from: data)
            completion(photos)
        }) { (message) in
            error(message)
        }
    }
}
