//
//  HTTPRequestManager.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

class HTTPRequestManager {
    
    typealias SuccessHandler = (Data) throws -> Void
    typealias FailureHandler = (String)-> Void
    typealias Parameter = [String: Any]?
    
    
    private func request(method: HTTPMethod, api: String, parameters: Parameter, head: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
        
        if !isConnectedToNetwork() {
            error("Нет подключения к интернету")
            return
        }
        
        let APIaddress = api.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var header: HTTPHeaders = [:]
        
        Alamofire.request(APIaddress!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response:DataResponse<Any>) in
            
            guard response.response != nil else {
                error("Не удалось загрузить данные.")
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                error("Не удалось получить код статуса HTTP")
                return
            }
            
            print("\(statusCode) - \(api)")
            do {
                switch(statusCode) {
                case 200,
                     201,
                     202:
                    try completion(response.data!)
                    break
                default:
                    error("")
                }
            } catch {
                print("Неизвестная ошибка: \(error).")
            }
        }
    }
    
    internal func get(api: String, head: String = "", completion: @escaping SuccessHandler, error: @escaping FailureHandler) {
        self.request(method: .get, api: api, parameters: nil, head: head, completion: completion, error: error)
    }
    
    // MARK: - Internet Connectivity
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
