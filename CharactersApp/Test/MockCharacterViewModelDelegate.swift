//
//  MockCharacterViewModelDelegate.swift
//  CharactersAppTests
//
//  Created by Sarah Gamal on 02/12/2024.
//

import XCTest
@testable import CharactersApp

class MockCharacterViewModelDelegate: CharacterViewModelDelegate {
    var isLoadingStateChanged: Bool?
    var didUpdateCharactersCalled = false
    var didEncounterErrorCalled = false
    var errorMessage: String?

    // Called when the loading state changes
    func didChangeLoadingState(isLoading: Bool) {
        isLoadingStateChanged = isLoading
    }

    // Called when characters are updated
    func didUpdateCharacters() {
        didUpdateCharactersCalled = true
    }

    // Called when an error is encountered
    func didEncounterError(message: String) {
        errorMessage = message
        didEncounterErrorCalled = true
    }
}
