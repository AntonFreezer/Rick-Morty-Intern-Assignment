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
        
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: Colors.EpisodeSeasonColor.rawValue)
        
        return label
    }()

//    private let spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//
//        spinner.hidesWhenStopped = true
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//
//        return spinner
//    }()
    
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
        
//        addSubview(characterImageView)
//        addSubview(characterNameLabel)
//        addSubview(characterStatusLabel)
        addSubview(collectionView)
//        addSubview(spinner)
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView.self else {
            return
        }
        
        NSLayoutConstraint.activate([
//            spinner.widthAnchor.constraint(equalToConstant: 100),
//            spinner.heightAnchor.constraint(equalToConstant: 100),
//            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
//            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
//            characterImageView.topAnchor.constraint(equalTo: topAnchor),
//            characterImageView.leftAnchor.constraint(equalTo: leftAnchor),
//            characterImageView.rightAnchor.constraint(equalTo: rightAnchor),
//            
//            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
//            characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            
//            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
//            characterStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            characterStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
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
        
        collectionView.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterOriginCollectionViewCell.self, forCellWithReuseIdentifier: CharacterOriginCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.cellIdentifier)
        
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

