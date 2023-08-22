//
//  SectionFooterCollectionReusableView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

final class SectionFooterCollectionReusableView: UICollectionReusableView {
    static let identifier = "SectionFooterCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        
        spinner.color = .darkGray
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFooterView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupFooterView() {
        backgroundColor = UIColor(named: Colors.defaultBackgroundColor.rawValue)
        addSubview(spinner)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 75),
            spinner.heightAnchor.constraint(equalToConstant: 75),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
