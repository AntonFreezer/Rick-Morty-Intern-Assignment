//
//  CharacterDetailView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

final class CharacterDetailView: UIView {
    
    //MARK: - Properties
    
    private let viewModel: CharacterDetailViewModel
    
    //MARK: - UI Components
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: Colors.EpisodeSeasonColor.rawValue)
        label.textAlignment = .center
        
        return label
    }()
    
    public var collectionView: UICollectionView?
    
    //MARK: - Lifecycle & Setup
    
    init(frame: CGRect, viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setupView()
        setupLayout()
        populateUpperElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupView() {
        backgroundColor = UIColor.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        addSubview(characterStatusLabel)
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView.self else {
            return
        }
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 148),
            characterImageView.widthAnchor.constraint(equalToConstant: 148),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20),
            characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 5),
            characterStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: characterStatusLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func populateUpperElements() {
        characterNameLabel.text = viewModel.characterName
        characterStatusLabel.text = viewModel.characterStatus
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .failure:
                break
                
            case .success(let data):
                DispatchQueue.main.async {
                    self?.characterImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    //MARK: - CollectionView
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: Colors.DefaultBackgroundColor.rawValue)
        
        collectionView.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterOriginCollectionViewCell.self, forCellWithReuseIdentifier: CharacterOriginCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.cellIdentifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
        
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .info:
            return viewModel.createInfoSectionLayout()
        case .origin:
            return viewModel.createOriginSectionLayout()
        case .episodes:
            return viewModel.createEpisodeSectionLayout()
        }
    }
}

