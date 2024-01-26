//
//  Character.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import Foundation

struct Character: Decodable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: Origin
    let location: CharacterCurrentLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
