//
//  CharactersListViewController.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit

final class CharactersListViewController: GenericViewController<CharacterListView> {
    
    //MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lifecycle & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        rootView.backgroundColor = UIColor.backgroundColor
        
        setupView()
    }
    
    private func setupView() {
        rootView.delegate = self
        
//        NSLayoutConstraint.activate([
//            rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            rootView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            rootView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            rootView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
}

//MARK: - CharacterListView Delegate

extension CharactersListViewController: CharacterListViewDelegate {
    func characterListView(_ characterListView: CharacterListView, didSelectCharacter character: Character) {
        let viewModel = CharacterDetailViewModel(character: character)
        let characterDetailVC = CharacterDetailViewController(viewModel: viewModel)
        characterDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}
