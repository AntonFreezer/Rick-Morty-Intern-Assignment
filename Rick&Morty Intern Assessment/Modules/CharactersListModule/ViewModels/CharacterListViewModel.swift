//
//  CharacterListViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit

protocol CharacterListViewModelDelegate: AnyObject {
    func didLoadFirstCharacters()
    func didLoadCharacters()
    func didSelectCharacter(_ character: Character)
}

final class CharacterListViewModel: NSObject {
    
    //MARK: - Properties
    
    public weak var delegate: CharacterListViewModelDelegate?
    
    private var isLoadingCharacters = false
    
    private var characters: [Character] = []
    
    private var currentResponseInfo: GetAllCharactersResponse.Info? = nil
    
    //MARK: - Network
    
    /// First fetch from API containing 20 Character objects
    public func fetchFirstCharacters() { }
    
    /// General fetching from API 
    public func fetchCharacters() { }
}

//MARK: - CollectionView DataSource&Delegate

extension CharacterListViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // cell implementation
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cell implementation
        
        return UICollectionViewCell()
    }
    
    
}
