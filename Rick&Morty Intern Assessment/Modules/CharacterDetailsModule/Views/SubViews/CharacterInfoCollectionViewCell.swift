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
    
    private var speciesLabel: DualLabelView {
        let speciesLabel = DualLabelView(frame: .zero)
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.leftText = "Species:"
        
        return speciesLabel
    }
    private var typeLabel: DualLabelView {
        let typeLabel = DualLabelView(frame: .zero)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.leftText = "Type:"
        
        return typeLabel
    }
    private var genderLabel: DualLabelView {
        let genderLabel = DualLabelView(frame: .zero)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.leftText = "Gender:"
        
        return genderLabel
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
        
        contentView.addSubview(speciesLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(genderLabel)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = contentView.bounds.height / 12
    }
    
    private func setupLayout() {
//        NSLayoutConstraint.activate([
//            // speciesLabel
//            speciesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
//            speciesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
//            speciesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
//            
//            // typeLabel
//            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 7),
//            typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
//            typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
//            
//            // genderLabel
//            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 7),
//            genderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
//            genderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
//        ])
    }
    
    public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel) {
        speciesLabel.rightText = viewModel.species
        typeLabel.rightText = viewModel.type
        genderLabel.rightText = viewModel.gender.rawValue
    }
}
