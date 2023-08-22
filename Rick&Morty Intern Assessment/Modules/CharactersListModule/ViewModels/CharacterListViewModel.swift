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
    
    private var characters: [Character] = [] {
        didSet {
            for character in characters {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageURL: URL(string: character.image)
                )
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    
    private var currentResponseInfo: GetAllCharactersResponse.Info? = nil
    
    //MARK: - Network
    
    /// First fetch from API containing 20 Character objects
    public func fetchFirstCharacters() {
        APIService.shared.execute(.allCharactersRequest, expecting: GetAllCharactersResponse.self) { [weak self] result in
            switch result {
                
            case .failure(let error):
                print(String(describing: error))
                
            case.success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                
                self?.characters = results
                self?.currentResponseInfo = info
                
                DispatchQueue.main.async {
                    self?.delegate?.didLoadFirstCharacters()
                }
            }
        }
    }
    
    /// General fetching from API 
    public func fetchCharacters() { }
}

//MARK: - CollectionView DataSource&Delegate

extension CharacterListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Could not create cell for \(indexPath.item)")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width-25) / 2
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
}
