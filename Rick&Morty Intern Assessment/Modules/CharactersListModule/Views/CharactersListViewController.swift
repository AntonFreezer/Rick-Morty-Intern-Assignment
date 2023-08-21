//
//  CharactersListViewController.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit

final class CharactersListViewController: UIViewController {
    
    //MARK: - Properties
    
    private let characterListView = CharacterListView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lifecycle & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
    
    private func setupViewController() {
        let largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
            
        title = "Characters"
    }
    
    private func setupView() {
        characterListView.delegate = self
        
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - CharacterListView Delegate

extension CharactersListViewController: CharacterListViewDelegate {
    func characterListView(_ characterListView: CharacterListView, didSelectCharacter character: Character) {
        // CharacterDetailsModule implementation and navigation
    }
    
    
}
