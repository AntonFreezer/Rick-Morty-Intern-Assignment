//
//  CharacterInfoCollectionViewCellView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static var cellIdentifier: String {
        return String(describing: CharacterInfoCollectionViewCell.self)
    }
    
    //MARK: - UI Components
    
    private var speciesLabel: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.leadingText = "Species:"
        label.leadingTextColor = .lightGray
        label.trailingTextColor = .white
        
        return label
    }()
    private var typeLabel: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium )
        label.leadingText = "Type:"
        label.leadingTextColor = .lightGray
        label.trailingTextColor = .white
        return label
    }()
    
    private var genderLabel: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.leadingText = "Gender:"
        label.leadingTextColor = .lightGray
        label.trailingTextColor = .white
        
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        return stackView
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
        
        stackView.addArrangedSubview(speciesLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(genderLabel)
        
        contentView.addSubview(stackView)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = contentView.bounds.height / 10
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
    //MARK: - ViewModel
    
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
