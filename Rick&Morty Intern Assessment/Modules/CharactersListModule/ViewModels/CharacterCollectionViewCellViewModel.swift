//
//  CharacterCollectionViewCellViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import Foundation

final class CharacterCollectionViewCellViewModel {
    
    //MARK: - Properties
    
    public let characterName: String
    public let characterStatus: CharacterStatus
    private let characterImageURL: URL?
    
    //MARK: - Lifecycle
    
    init(characterName: String, characterStatus: CharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    //MARK: - Network
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageManager.shared.downloadImage(url, completion: completion)
    }
}

//MARK: - Hashable & Equatable

extension CharacterCollectionViewCellViewModel: Hashable, Equatable {
    static func == (lhs: CharacterCollectionViewCellViewModel, rhs: CharacterCollectionViewCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    
}
