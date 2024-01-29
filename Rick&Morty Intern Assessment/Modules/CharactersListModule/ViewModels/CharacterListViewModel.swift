//
//  CharacterListViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit
import Combine

protocol CharacterListViewModelDelegate: AnyObject {
    func didLoadCharacters()
}

final class CharacterListViewModel: NSObject, ViewModelType {
    
    //MARK: - IO

    enum Input {
        case viewDidLoad
        case onScrollPaginated
    }
    
    enum Output {
        case didLoadCharacters
        case didSelectCharacter(character: Character)
    }
    
    var output: any Subject = PassthroughSubject<Output, Never>()
    var cancellables = Set<AnyCancellable>()
    
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
                    self.delegate?.didLoadCharacters()
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
                self.characters.append(contentsOf: results)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadCharacters()
                    self.isLoadingCharacters = false
                }
            }
        }
    }
}


