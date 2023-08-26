//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import Foundation

protocol EpisodeDataRepresentable {
    var episode: String { get }
    var name: String { get }
    var air_date: String { get }
}

final class CharacterEpisodeCollectionViewCellViewModel {
    
    //MARK: - Properties
    let episodeURL: URL?
    private var episodeDataBlock: ((EpisodeDataRepresentable) -> Void)?
    
    private var episode: Episode? {
        didSet {
            guard let model = episode else {
                return
            }
            
            episodeDataBlock?(model)
        }
    }
    
    private var isFetching = false
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    //MARK: - Lifecycle & Setup
    
    init(episodeURL: URL?) {
        self.episodeURL = episodeURL
    }
    
    public func registerForData(_ block: @escaping (EpisodeDataRepresentable) -> Void) {
        self.episodeDataBlock = block
    }
    
    //MARK: - Network
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                episodeDataBlock?(model)
            }
            return
        }
        
        guard let url = episodeURL,
              let request = APIRequest(url: url) else {
            return
        }
        isFetching = true
        
        APIService.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
                
            case .failure(let failure):
                print(String(describing: failure))
                
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            }
        }
    }
}
