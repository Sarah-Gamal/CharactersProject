//
//  CharacterService.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 29/11/2024.
//

import Foundation
import Alamofire

protocol CharacterServiceProtocol {
    func fetchCharacters(forPage page: Int) async throws -> CharacterResponse
}

class CharacterService: CharacterServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api/"
    func fetchCharacters(forPage page: Int) async throws -> CharacterResponse {
        let urlString =  baseURL + APIEndPoints.charactersEndPoint(page: page)
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlString)
                .validate()
                .responseDecodable(of: CharacterResponse.self) { response in
                    switch response.result {
                    case .success(let characterResponse):
                        continuation.resume(returning: characterResponse)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
