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
    
    private var iconImage: UIImageView {
        let image = UIImageView(frame: .zero)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(red: 0.25, green: 0.28, blue: 0.42, alpha: 1)
        image.image = UIImage(named: Images.planetIcon.rawValue)
        
        return image
    }
    private var originNameLabel: UILabel {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        return label
    }
    private var originTypeLabel: UILabel {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: Colors.EpisodeSeasonColor.rawValue)
        
        return label
    }
    
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
        
        contentView.addSubview(iconImage)
        contentView.addSubview(originNameLabel)
        contentView.addSubview(originTypeLabel)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = contentView.bounds.height / 12
    }
    
    private func setupLayout() {
//        NSLayoutConstraint.activate([
//            // iconImage
//            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
//            iconImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
//            iconImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
//            
//            // originNameLabel
//            originNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            originNameLabel.leadingAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 10),
//            originNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
//            
//            // originTypeLabel
//            originTypeLabel.topAnchor.constraint(equalTo: originNameLabel.bottomAnchor, constant: 10),
//            originTypeLabel.leadingAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 10),
//            originTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
//        ])
    }
    
    public func configure(with viewModel: CharacterOriginCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.originNameLabel.text = data.name
            self?.originTypeLabel.text = data.type
        }
        
        viewModel.fetchLocation()
    }
}
