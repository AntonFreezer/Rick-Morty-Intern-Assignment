//
//  CharacterInfoCollectionViewCellViewModel.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 22.08.2023.
//


import UIKit

final class CharacterInfoCollectionViewCellViewModel {
    
    private let character: Character
    
    let species: String
    let type: String
    let gender: CharacterGender
    
    init(character: Character) {
        self.character = character
        
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
    }
}
