//
//  CharacterListViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit
import Combine

final class CharacterListViewModel: NSObject, ViewModelType {
    
    //MARK: - IO

    enum Input {
        case viewDidLoad
        case onScrollPaginated(url: URL)
    }
    
    enum Output {
        case didLoadCharacters
    }
    
    var output: AnyPublisher<Output, Never> {
        return subject.eraseToAnyPublisher()
    }
    private let subject = PassthroughSubject<Output, Never>()
    
    var cancellables = Set<AnyCancellable>()
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [unowned self] event in
            switch event {
            case .viewDidLoad:
                fetchFirstCharacters()
                subject.send(.didLoadCharacters)
            case .onScrollPaginated(let url):
                fetchCharacters(url: url)
                subject.send(.didLoadCharacters)
            }
        }.store(in: &cancellables)
        
        return output
    }
    
    //MARK: - Properties
    
    enum Section {
        case Character
    }
    
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
                    self.subject.send(.didLoadCharacters)
                }
            }
        }
    }
    
    /// General fetching from API
    public func fetchCharacters(url: URL) {
        guard !isLoadingCharacters,
              shouldShowMoreIndicator
        else { return }
        
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
                    self.subject.send(.didLoadCharacters)
                    self.isLoadingCharacters = false
                }
            }
        }
    }
}


