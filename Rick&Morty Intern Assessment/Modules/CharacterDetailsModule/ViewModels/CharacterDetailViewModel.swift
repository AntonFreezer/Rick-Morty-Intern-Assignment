//
//  CharacterDetailViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

final class CharacterDetailViewModel {
    
    //MARK: - Properties
    
    private let character: Character
    
    public var characterName: String {
        character.name.uppercased()
    }
    
    public var characterStatus: String {
        character.status.text
    }

    public var episodes: [String] {
        character.episode
    }
    
    private var imageURL: URL? {
        URL(string: character.image)
    }
    
    enum SectionType {
        case info(viewModel: CharacterInfoCollectionViewCellViewModel)
        case origin(viewModel: CharacterOriginCollectionViewCellViewModel)
        case episodes(viewModels: [CharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
        
    //MARK: - Lifecycle & Setup
    
    init(character: Character) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .info(viewModel: .init(character: character)),
            .origin(viewModel: .init(originURLString: character.origin.url)),
            .episodes(viewModels: character.episode.compactMap {
                CharacterEpisodeCollectionViewCellViewModel(episodeURL: URL(string: $0))
            })
        ]
    }
    
    //MARK: - Network
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void) {
        guard let imageURL = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageManager.shared.downloadImage(imageURL, completion: completion)
    }
    
    //MARK: - CollectionView Layouts
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),                                                      heightDimension: .absolute(25.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: footerHeaderSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        
        return header
    }
    
    public func createInfoSectionLayout()  -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 0.5, bottom: 10, trailing: 0.5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ), subitems: [item, item]
        )
        
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    public func createOriginSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 0.5, bottom: 10, trailing: 0.5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)),
            subitems: [item]
        )
        
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
        
    }
    
    public func createEpisodeSectionLayout()  -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 0.5, bottom: 10, trailing: 0.5)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ), subitems: [item]
        )
        
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]        
        section.orthogonalScrollingBehavior = .none
        return section
    }
}
