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
    
    public var shouldShowMoreIndicator: Bool {
        return currentResponseInfo?.next != nil
    }
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
        let height = width * 1.35
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    // Footer
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let footerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: SectionFooterCollectionReusableView.identifier,
            for: indexPath) as? SectionFooterCollectionReusableView
        else {
            fatalError("Could not dequeue footer view with \(SectionFooterCollectionReusableView.identifier)")
        }
        
        footerView.startAnimating()
        
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

//MARK: - ScrollView Delegate & Pagination

extension CharacterListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowMoreIndicator,
              !isLoadingCharacters,
              !cellViewModels.isEmpty,
              let nextURL = currentResponseInfo?.next,
              let url = URL(string: nextURL) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
                self?.fetchCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
