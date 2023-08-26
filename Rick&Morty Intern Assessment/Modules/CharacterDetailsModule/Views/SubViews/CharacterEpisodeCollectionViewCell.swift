//
//  CharacterEpisodeCollectionViewCell.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 24.08.2023.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let cellIdentifier = "CharacterEpisodeCollectionViewCell"
    
    //MARK: - UI Components
    
    private let episodeNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        return label
    }()
    
    private let episodeSeasonLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: Colors.EpisodeSeasonColor.rawValue)
        label.textAlignment = .left
        
        return label
    }()
    
    private let episodeAirDateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        
        return label
    }()
    
    //MARK: - Init & Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = UIColor(named: Colors.CharacterDetailViewCellColor.rawValue)
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(episodeNameLabel)
        contentView.addSubview(episodeSeasonLabel)
        contentView.addSubview(episodeAirDateLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            episodeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            episodeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            episodeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            episodeSeasonLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 10),
            episodeSeasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            episodeSeasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            episodeSeasonLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            episodeAirDateLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 10),
            episodeAirDateLabel.leadingAnchor.constraint(equalTo: episodeSeasonLabel.trailingAnchor, constant: 10),
            episodeAirDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            episodeAirDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    //MARK: - ViewModel
    
    public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.episodeNameLabel.text = data.name
            self?.episodeSeasonLabel.text = data.episode
            self?.episodeAirDateLabel.text = data.air_date
        }
        
        viewModel.fetchEpisode()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeNameLabel.text = nil
        episodeSeasonLabel.text = nil
        episodeAirDateLabel.text = nil
    }
}
