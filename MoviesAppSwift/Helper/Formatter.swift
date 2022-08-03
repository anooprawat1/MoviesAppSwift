//
//  Formatter.swift
//  MoviesAppSwift
//
//  Created by Anoop on 02.08.22.
//

import Foundation

struct Formatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

