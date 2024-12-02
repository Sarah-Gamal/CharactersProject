//
//  CharacterServiceTests.swift
//  CharactersAppTests
//
//  Created by Sarah Gamal on 02/12/2024.
//

import Foundation
import XCTest
@testable import CharactersApp

class CharacterServiceTests: XCTestCase {
    var service: CharacterService!
    var mockService: MockCharacterService!

    override func setUp() {
        super.setUp()
        service = CharacterService()
        mockService = MockCharacterService()
    }

    override func tearDown() {
        service = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() async {
        let location = Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/1")
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            location: location
        )
        
        let characterResponse = CharacterResponse(
            info: Info(count: 1, pages: 1, next: nil, prev: nil),
            results: [character]
        )
        
        mockService.charactersToReturn = characterResponse

        do {
            let response = try await mockService.fetchCharacters(forPage: 1)
            XCTAssertEqual(response.results.count, 1)
            XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
            XCTAssertEqual(response.results.first?.species, "Human")
            XCTAssertEqual(response.results.first?.gender, "Male")
            XCTAssertEqual(response.results.first?.status, "Alive")
            XCTAssertEqual(response.results.first?.location.name, "Earth")
            XCTAssertNil(response.info.next)
        } catch {
            XCTFail("Expected successful fetch, but got error: \(error)")
        }
    }

    func testFetchCharactersFailure() async {
        mockService.shouldReturnError = true

        do {
            _ = try await mockService.fetchCharacters(forPage: 1)
            XCTFail("Expected error, but got success")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }

    func testFetchCharactersNoData() async {
        mockService.charactersToReturn = nil

        do {
            _ = try await mockService.fetchCharacters(forPage: 1)
            XCTFail("Expected error due to no data, but got success")
        } catch {
            XCTAssertEqual((error as NSError).domain, "No data")
            XCTAssertEqual((error as NSError).code, 0)
        }
    }
}
