//
//  APIEndpoint.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 30/11/2024.
//

import Foundation

struct APIEndPoints {
    
    // MARK : - Characters
    static func charactersEndPoint(page: Int) -> String {
        return "character?page=\(page)"
    }
}
