//
//  CharacterOriginCollectionViewCellViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//

import Foundation

protocol LocationDataRepresentable {
    var id: Int { get }
    var name: String { get }
    var type: String { get }
}

final class CharacterOriginCollectionViewCellViewModel {
    
    //MARK: - Properties
    
    let originURL: URL?
    private var originDataBlock: ((LocationDataRepresentable) -> Void)?
    
    private var origin: CharacterLocation? {
        didSet {
            guard let model = origin else {
                return
            }
            
            originDataBlock?(model)
        }
    }
    
    private var isFetching = false
    
    //MARK: - Lifecycle & Setup
    
    init(originURLString: String) {
        self.originURL = URL(string: originURLString)
    }
    
    public func registerForData(_ block: @escaping (LocationDataRepresentable) -> Void) {
        self.originDataBlock = block
    }
    
    //MARK: - Network
    
    public func fetchLocation() {
        guard !isFetching else {
            if let model = origin {
                originDataBlock?(model)
            }
            return
        }
        
        guard let url = originURL,
              let request = APIRequest(url: url) else {
            return
        }
        isFetching = true
        
        APIService.shared.execute(request, expecting: CharacterLocation.self) { [weak self] result in
            switch result {
                
            case .failure(let failure):
                print(String(describing: failure))
                
            case .success(let model):
                DispatchQueue.main.async {
                    self?.origin = model
                }
            }
        }
    }
}
