//
//  CharacterCollectionViewCell.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterCollectionViewCell"
    
    //MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        contentView.backgroundColor = UIColor(named: Colors.CharactersViewCellColor.rawValue)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.systemBackground.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.2
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
        ])
    }
    
    //MARK: - CharacterCollectionViewCell View Model
    
    public func configure(with viewModel: CharacterCollectionViewCellViewModel) {
        // Text
        nameLabel.text = viewModel.characterName
        // Image
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
