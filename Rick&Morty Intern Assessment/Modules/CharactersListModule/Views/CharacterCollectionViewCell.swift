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
        
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
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
        // contentView
        contentView.layer.cornerRadius = contentView.bounds.height / 12
        
        // imageView
        imageView.layer.cornerRadius = (contentView.bounds.height / 12) - 5
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // imageView
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.nameLabel.text = nil
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
