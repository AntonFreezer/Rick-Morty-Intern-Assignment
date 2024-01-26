//
//  CharacterListViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit

protocol CharacterListViewModelDelegate: AnyObject {
    func didLoadFirstCharacters()
    func didLoadCharacters(with indexPaths: [IndexPath])
    func didSelectCharacter(_ character: Character)
}

final class CharacterListViewModel: NSObject {
    
    //MARK: - IO
    
    enum Input {
        case viewDidLoad
        case onScrollPaginated
    }
    
    enum Output {
        case didLoadFirstCharacters
        case didLoadCharacters(indexPaths: [IndexPath])
        case didSelectCharacter(character: Character)
    }
    
    //MARK: - Properties
    
    enum Section {
        case Character
    }
    
    public weak var delegate: CharacterListViewModelDelegate?
    
    private(set) var isLoadingCharacters = false
    
    private(set) var characters: [Character] = []
    
    private(set) var currentResponseInfo: GetAllCharactersResponse.Info? = nil
    
    public var shouldShowMoreIndicator: Bool {
        return currentResponseInfo?.next != nil
    }
    
    //MARK: - Network
    
    /// First fetch from API containing 20 Character objects
    public func fetchFirstCharacters() {
        APIService.shared.execute(.allCharactersRequest, expecting: GetAllCharactersResponse.self) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
                
            case .failure(let error):
                print(String(describing: error))
                
            case.success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                
                self.characters = results
                self.currentResponseInfo = info
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadFirstCharacters()
                }
            }
        }
    }
    
    /// General fetching from API
    public func fetchCharacters(url: URL) {
        guard !isLoadingCharacters else { return }
        isLoadingCharacters = true
        
        guard let request = APIRequest(url: url) else {
            isLoadingCharacters = false
            return
        }
        
        APIService.shared.execute(request, expecting: GetAllCharactersResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .failure(let error):
                self.isLoadingCharacters = false
                print(String(describing: error))
                
            case.success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self.currentResponseInfo = info
                
                let oldCount = self.characters.count
                let newCount = results.count
                let totalCount = oldCount + newCount
                
                let startingIndex = totalCount - newCount
                let lastIndex = startingIndex + newCount
                print(startingIndex, lastIndex)
                
                let indexPaths = Array(startingIndex..<lastIndex).compactMap(
                    { IndexPath(row: $0, section: 0) })
                
                self.characters.append(contentsOf: results)
                DispatchQueue.main.async {
                    self.delegate?.didLoadCharacters(with: indexPaths)
                    self.isLoadingCharacters = false
                }
            }
        }
    }
}


