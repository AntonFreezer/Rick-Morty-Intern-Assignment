//
//  CharacterInfoCollectionViewCellView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let cellIdentifier = "CharacterInfoCollectionViewCell"
    
    //MARK: - UI Components
    
    private var speciesLabel: DualLabelView = {
        let speciesLabel = DualLabelView(frame: .zero)
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.leadingText = "Species:"
        
        return speciesLabel
    }()
    private var typeLabel: DualLabelView = {
        let typeLabel = DualLabelView(frame: .zero)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.leadingText = "Type:"
        
        return typeLabel
    }()
    
    private var genderLabel: DualLabelView = {
        let genderLabel = DualLabelView(frame: .zero)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.leadingText = "Gender:"
        
        return genderLabel
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
        
        contentView.addSubview(speciesLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(genderLabel)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = contentView.bounds.height / 12
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            // speciesLabel
//            speciesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
//            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
//            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
//            
//            // typeLabel
//            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 7),
//            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
//            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
//
//            // genderLabel
//            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 7),
//            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
//            genderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
//            genderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
    }
    
    public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel) {
        speciesLabel.trailingText = viewModel.species
        typeLabel.trailingText = viewModel.type
        genderLabel.trailingText = viewModel.gender.rawValue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        speciesLabel.trailingText = nil
        typeLabel.trailingText = nil
        genderLabel.trailingText = nil
    }
}
