//
//  CharacterService.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 29/11/2024.
//

import Foundation

protocol CharacterServiceProtocol {
  func fetchCharacters(forPage page: Int) async throws -> CharacterResponse
}

class CharacterService: CharacterServiceProtocol {

    private let baseURL = "https://rickandmortyapi.com/api/"

    func fetchCharacters(forPage page: Int) async throws -> CharacterResponse {
        let urlString = baseURL + APIEndPoints.charactersEndPoint(page: page)

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        // Assuming the video suggests using URLSession for network requests:
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.unexpectedResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(CharacterResponse.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

// Define a custom NetworkError type for handling potential network issues:
enum NetworkError: Error {
    case invalidURL
    case unexpectedResponse(statusCode: Int)
    case decodingError(_: Error)
}
