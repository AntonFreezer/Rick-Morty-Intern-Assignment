//
//  DualLabelView.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

class DualLabelView: UIView {
    
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()

    // Shared properties
    var font: UIFont = .systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            leftLabel.font = font
            rightLabel.font = font
        }
    }

    // Individual properties for left label
    var leftText: String? {
        get { return leftLabel.text }
        set { leftLabel.text = newValue }
    }
    
    var leftFont: UIFont? {
        get { return leftLabel.font }
        set { leftLabel.font = newValue }
    }

    // Individual properties for right label
    var rightText: String? {
        get { return rightLabel.text }
        set { rightLabel.text = newValue }
    }
    
    var rightFont: UIFont? {
        get { return rightLabel.font }
        set { rightLabel.font = newValue }
    }
    
    /// Initialize and set up the subviews and constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        
        leftLabel.textAlignment = .left
        rightLabel.textAlignment = .right
    }
    
    private func setupConstraints() {
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLabel.topAnchor.constraint(equalTo: topAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor),
        ])
    }
}

