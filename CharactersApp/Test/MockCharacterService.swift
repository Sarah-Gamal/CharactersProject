//
//  MockCharacterService.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 02/12/2024.
//

import Foundation
import XCTest
@testable import CharactersApp

class MockCharacterService: CharacterServiceProtocol {
    
    var shouldReturnError = false
    var charactersToReturn: CharacterResponse?

    func fetchCharacters(forPage page: Int) async throws -> CharacterResponse {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        guard let charactersToReturn = charactersToReturn else {
            throw NSError(domain: "No data", code: 0, userInfo: nil)
        }
        return charactersToReturn
    }
}
