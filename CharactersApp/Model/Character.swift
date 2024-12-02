//
//  Character.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 29/11/2024.
//

import Foundation

// MARK: - CharacterResponse
struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: Location
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
