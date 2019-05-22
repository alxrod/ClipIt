//
//  NetworkingClient.swift
//  ClipIt
//
//  Created by Alex Rodriguez on 5/22/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    
    let root = "127.0.0.1"
    
    typealias WebServiceResponse = (String?,Error?) -> Void
    
    func log_in(username: String, password: String, completion: @escaping WebServiceResponse) {
        
        var components = URLComponents()
        
        components.scheme = "http"
        components.host = root
        components.path = "/auth/"
        components.port = 5000
        let queryItemName = URLQueryItem(name: "username", value: username)
        let queryItemPword = URLQueryItem(name: "password", value: password)
        
        components.queryItems = [queryItemName, queryItemPword]

        guard let url = components.url else { return }
        
        print("final url: \(url)")
        print("based off \(username) and \(password)")
        
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = "POST"
        AF.request(urlRequest).validate().responseJSON { response in
            switch response.result {
                case let .success(value):
                    if let token = value as? String {
                        completion(token,nil)
                    }
                case let .failure(error):
                    completion(nil,error)
            
            }
        }
    }
}
