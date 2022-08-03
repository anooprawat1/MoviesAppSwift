//
//  RequestError.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case.invalidURL:
            return "Invalid Url error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
