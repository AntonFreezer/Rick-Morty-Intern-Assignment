//
//  ViewModelType.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 28.01.2024.
//

import Combine

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get }
    
}
