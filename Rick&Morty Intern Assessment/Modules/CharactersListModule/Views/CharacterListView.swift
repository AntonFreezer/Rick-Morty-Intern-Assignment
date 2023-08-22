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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(named: Colors.defaultBackgroundColor.rawValue)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
        collectionView.register(SectionFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterCollectionReusableView.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //MARK: - Lifecycle & Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        setupLayout()
        setupViewModel()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
    
    func didLoadCharacters(with indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPaths)
        }
    }
    
    func didSelectCharacter(_ character: Character) {
        delegate?.characterListView(self, didSelectCharacter: character)
    }
}
