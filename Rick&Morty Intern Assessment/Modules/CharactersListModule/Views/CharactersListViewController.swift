//
//  CharactersListViewController.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import UIKit
import Combine

final class CharactersListViewController: GenericViewController<CharacterListView> {
    
    //MARK: - Properties
    
    private typealias DataSource = UICollectionViewDiffableDataSource<CharacterListViewModel.Section, Character>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterListViewModel.Section, Character>
    
    private var dataSource: DataSource!
    
    private let viewModel: CharacterListViewModel
    
    private var output: AnyPublisher<CharacterListViewModel.Input, Never> {
        return subject.eraseToAnyPublisher()
    }
    private let subject = PassthroughSubject<CharacterListViewModel.Input, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lifecycle & Setup
    
    init(viewModel: CharacterListViewModel = CharacterListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        setupView()
        bindViewModel()
        
        subject.send(.viewDidLoad)
    }
    
    private func setupView() {
        rootView.collectionView.delegate = self
        
        title = "Characters"
        rootView.backgroundColor = UIColor.backgroundColor
    }
    
    private func bindViewModel() {
        viewModel.transform(input: output).sink { [unowned self] event in
            switch event {
            case .didLoadCharacters:
                self.applyShapshot()
            }
        }.store(in: &cancellables)
    }
    
}

//MARK: - UICollectionViewDiffableDataSource && Snapshot

private extension CharactersListViewController {
    func configureDataSource() {
        dataSource = DataSource(collectionView: rootView.collectionView, cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell
            
            cell?.configure(with: CharacterCollectionViewCellViewModel(
                characterName: character.name,
                characterStatus: character.status,
                characterImageURL: URL(string: character.image)))
            
            return cell
        })
        
        setupSupplementaryViews()
    }
    
    func applyShapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.Character])
        snapshot.appendItems(viewModel.characters)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

//MARK: - CollectionView Delegate

extension CharactersListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width-25) / 2
        let height = width * 1.35
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = dataSource.itemIdentifier(for: indexPath) else { return }
        
        // coordinator logic
        self.didSelectCharacter(character)
    }
    
}

//MARK: - CollectionView Delegate FlowLayout & Supplementary Views

extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
    
    func setupSupplementaryViews() {
        // Footer
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionFooter else {
                return nil
            }
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterCollectionReusableView.identifier, for: indexPath) as? SectionFooterCollectionReusableView
            
            footer?.startAnimating()
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard viewModel.shouldShowMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

//MARK: - ScrollView Delegate & Pagination

extension CharactersListViewController: UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        guard elementKind == UICollectionView.elementKindSectionFooter,
              !viewModel.isLoadingCharacters,
              viewModel.shouldShowMoreIndicator
        else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            if let nextURL = self?.viewModel.currentResponseInfo?.next,
               let url = URL(string: nextURL) {
                self?.viewModel.fetchCharacters(url: url)
            }
            
        }
    }
    
}

//MARK: - Navigation

extension CharactersListViewController {
    
    func didSelectCharacter(_ character: Character) {
        let viewModel = CharacterDetailViewModel(character: character)
        let characterDetailVC = CharacterDetailViewController(viewModel: viewModel)
        characterDetailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
    
}
