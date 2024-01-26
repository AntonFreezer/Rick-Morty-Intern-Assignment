//
//  SectionHeaderCollectionReusableView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 26.08.2023.
//

import UIKit

final class SectionHeaderCollectionReusableView: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: SectionHeaderCollectionReusableView.self)
    }
    
    public let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeaderView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupHeaderView() {
        backgroundColor = UIColor(named: Colors.DefaultBackgroundColor.rawValue)
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),    
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
