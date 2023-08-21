//
//  CharacterListView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit

protocol CharacterListViewDelegate: AnyObject {
    func characterListView(
        _ characterListView: CharacterListView,
        didSelectCharacter character: Character
    )
}

final class CharacterListView: UIView {
    
    //MARK: - Properties
    
    public weak var delegate: CharacterListViewDelegate?
    
    private let viewModel = CharacterListViewModel()
    
    //MARK: - UI Components
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    //MARK: - Lifecycle & Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        setupViewModel()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        // UI Components constraints implementation
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetchFirstCharacters()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
        
}
    //MARK: - CharacterListViewModel Delegate
    
extension CharacterListView: CharacterListViewModelDelegate {
    func didLoadFirstCharacters() {
        collectionView.reloadData()
        // animation
    }
    
    func didLoadCharacters() {
        collectionView.performBatchUpdates {
            // insert items by indexPath implementation
        }
        // animation
    }
    
    func didSelectCharacter(_ character: Character) {
        delegate?.characterListView(self, didSelectCharacter: character)
    }
    
    
}

