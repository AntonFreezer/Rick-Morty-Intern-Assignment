//
//  CharacterDetailViewController.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import UIKit

final class CharacterDetailViewController: GenericViewController<CharacterDetailView> {
    
    //MARK: - Properties
    
    private let viewModel: CharacterDetailViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lifecycle & Setup
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = CharacterDetailView(frame: .zero, viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.backgroundColor = UIColor.backgroundColor
        
        configureNavigationBar()
        
        rootView.collectionView?.delegate = self
        rootView.collectionView?.dataSource = self
    }
    
    private func configureNavigationBar() {
        self.title = ""
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
}

//MARK: - CollectionView

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Section
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .info:
            return 1
        case .origin:
            return 1
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    // Cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .info(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? CharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .origin(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterOriginCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterOriginCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath) as? CharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    // Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderCollectionReusableView.identifier,
            for: indexPath) as? SectionHeaderCollectionReusableView
        else {
            fatalError("Could not dequeue footer view with \(SectionHeaderCollectionReusableView.identifier)")
        }

        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .info:
            headerView.titleLabel.text = "Info"
            return headerView
        case .origin:
            headerView.titleLabel.text = "Origin"
            return headerView
        case .episodes:
            headerView.titleLabel.text = "Episodes"
            return headerView
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
    // Navigation
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sectionType = viewModel.sections[indexPath.section]
//
//        switch sectionType {
//        case .info, .origin:
//            break
//        case .episodes:
//            let episodes = self.viewModel.episodes
//            let selection = episodes[indexPath.row]
            
            // implementation of episode details module
//            let vc = EpisodeDetailViewController(url: URL(string:selection))
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
