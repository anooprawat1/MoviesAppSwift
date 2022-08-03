//
//  MoviesEndpoint.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

enum MoviesEndpoint {
    case discover
    case movieDetail(movieId: Int)
}

extension MoviesEndpoint: Endpoint {
   
    var path: String {
        switch self {
        case .discover:
            return "/3/discover/movie"
        case .movieDetail(let movieId):
            return "/3/movie/\(movieId)"
        }
    }
    
    var method: RequestMethod {
        return RequestMethod.get
    }
    
    var decoder: ResponseDecoder {
        return MovieDecoder()
    }
    
}

class MovieDecoder: ResponseDecoder {
    
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try jsonDecoder.decode(type, from: data)
    }
}
