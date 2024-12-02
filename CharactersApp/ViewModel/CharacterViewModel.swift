//
//  CharacterViewModel.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 29/11/2024.
//

import Foundation
import Alamofire

protocol CharacterViewModelDelegate: AnyObject {
    func didChangeLoadingState(isLoading: Bool)
    func didUpdateCharacters()
    func didEncounterError(message: String)
}

class CharacterViewModel {
    private(set) var characters = [Character]()
    private(set) var filteredCharacters = [Character]()
    private(set) var error: Error?
    private(set) var currentPage = 1
    private var nextPageURL: String?
    private var isLoading = false
    
    private let networkingService: CharacterServiceProtocol
    weak var delegate: CharacterViewModelDelegate?
        
    var hasNextPage: Bool {
        return nextPageURL != nil
    }
    
    var numberOfCharacters: Int {
        return filteredCharacters.count
    }
    
    func characterAt(index: Int) -> Character {
        return filteredCharacters[index]
    }
    
    init(networkingService: CharacterServiceProtocol = CharacterService()) {
        self.networkingService = networkingService
    }
    
    func resetPagination() {
        currentPage = 1
        nextPageURL = nil
        characters.removeAll()
    }
    
    // For testing
    func setCharacters(forTesting characters: [Character]) {
        self.characters = characters
    }
    
    // For testing
    func setCurrentPage(forTesting page: Int) {
        currentPage = page
    }
    
    func filterCharacters(by status: String) {
        filteredCharacters = status.isEmpty ? characters : characters.filter { $0.status == status }
        delegate?.didUpdateCharacters()
    }
    
    func fetchCharacters() async {
        guard !isLoading else { return }
        
        isLoading = true
        delegate?.didChangeLoadingState(isLoading: true)
        
        do {
            let response = try await networkingService.fetchCharacters(forPage: currentPage)
            DispatchQueue.main.async {
                self.characters.append(contentsOf: response.results)
                self.nextPageURL = response.info.next
                if self.nextPageURL != nil {
                    self.currentPage += 1
                }
                self.filteredCharacters = self.characters // Reset filter
                self.delegate?.didUpdateCharacters()
            }
        } catch  {
            DispatchQueue.main.async {
                self.error = error
                self.delegate?.didEncounterError(message: error.localizedDescription)
            }
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.delegate?.didChangeLoadingState(isLoading: false)
        }
    }
}
