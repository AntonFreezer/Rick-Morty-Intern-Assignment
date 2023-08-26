//
//  CharacterOriginCollectionViewCell.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 25.08.2023.
//

import UIKit

final class CharacterOriginCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let cellIdentifier = "CharacterOriginCollectionViewCell"
    
    //MARK: - UI Components
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(named: Colors.OriginIconBackgroundColor.rawValue)
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 14
        imageView.image = UIImage(named: Images.PlanetIcon.rawValue)
        
        return imageView
    }()
    
    private var originNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private var originTypeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: Colors.EpisodeSeasonColor.rawValue)
        
        return label
    }()
    
    //MARK: - Lifecycle & Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupLayer()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = UIColor(named: Colors.CharacterDetailViewCellColor.rawValue)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(originNameLabel)
        contentView.addSubview(originTypeLabel)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = 14
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // iconImage
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            iconImageView.heightAnchor.constraint(equalToConstant: 64),
            iconImageView.widthAnchor.constraint(equalToConstant: 64),

            // originNameLabel
            originNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            originNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            originNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            // originTypeLabel
            originTypeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            originTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            originTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17)
        ])
    }
    
    //MARK: - ViewModel
    
    public func configure(with viewModel: CharacterOriginCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.originNameLabel.text = data.name
            self?.originTypeLabel.text = data.type
        }
        
        viewModel.fetchLocation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        originNameLabel.text = nil
        originTypeLabel.text = nil
    }
}
