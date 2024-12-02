//
//  CharacterViewModelTests.swift
//  CharactersAppTests
//
//  Created by Sarah Gamal on 02/12/2024.
//

import Foundation
import XCTest
@testable import CharactersApp

class CharacterViewModelTests: XCTestCase {
    var viewModel: CharacterViewModel!
    var mockService: MockCharacterService!
    
    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        viewModel = CharacterViewModel(networkingService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchCharactersSuccess() async {
        let character = Character(id: 1,
                                  name: "Rick Sanchez",
                                  status: "Alive",
                                  species: "Human",
                                  gender: "Male",
                                  image: "https://example.com/image.png",
                                  location: Location(name: "Earth",
                                                     url: "https://example.com/location"))
        
        let response = CharacterResponse(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [character])
        mockService.charactersToReturn = response
        
        await viewModel.fetchCharacters()
        sleep(1)

        XCTAssertEqual(viewModel.numberOfCharacters, 1)
        XCTAssertEqual(viewModel.characterAt(index: 0).name, "Rick Sanchez")
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchCharactersFailure() async {
        
        mockService.shouldReturnError = true
        
        await viewModel.fetchCharacters()
        sleep(1)

        XCTAssertEqual(viewModel.numberOfCharacters, 0)
        XCTAssertNotNil(viewModel.error)
    }
        
    func testFilterCharacters() {
        let character1 = Character(id: 1,
                                   name: "Rick Sanchez",
                                   status: "Alive",
                                   species: "Human",
                                   gender: "Male",
                                   image: "https://example.com/image.png",
                                   location: Location(name: "Earth",
                                                      url: "https://example.com/location"))
        
        let character2 = Character(id: 2,
                                   name: "Morty Smith",
                                   status: "Alive",
                                   species: "Human",
                                   gender: "Male",
                                   image: "https://example.com/image2.png",
                                   location: Location(name: "Earth",
                                                      url: "https://example.com/location"))
        viewModel.setCharacters(forTesting: [character1, character2])
        
        viewModel.filterCharacters(by: "Alive")
        XCTAssertEqual(viewModel.numberOfCharacters, 2)
        
        viewModel.filterCharacters(by: "Dead")
        XCTAssertEqual(viewModel.numberOfCharacters, 0)
    }
    
    func testResetPagination() {
        viewModel.setCurrentPage(forTesting: 5)
        viewModel.resetPagination()
        
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertFalse(viewModel.hasNextPage)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
}
