//
//  ResponseDecoder.swift
//  MoviesAppSwift
//
//  Created by Anoop on 03.08.22.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}
