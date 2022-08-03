//
//  Endpoint.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

public protocol Endpoint {
    var path: String {get}
    var method: RequestMethod {get}
    var headers: [String: String]? {get}
    var body: Data? {get}
    var decoder: ResponseDecoder {get}
}

extension Endpoint {
 
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
    func urlRequest(_ config: ApiConfiguration) -> URLRequest? {
        var urlComponent = URLComponents()
        urlComponent.scheme = config.scheme
        urlComponent.host = config.host
        urlComponent.path = path
        var urlQueryItems = [URLQueryItem]()
        let queryItem = URLQueryItem(name: "api_key", value: config.apiKey)
        urlQueryItems.append(queryItem)
        urlComponent.queryItems = urlQueryItems
        if let url = urlComponent.url {
            var request = URLRequest(url: url)
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
        return nil
    }
}
