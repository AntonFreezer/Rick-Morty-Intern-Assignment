//
//  CharacterLocation.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import Foundation

struct CharacterLocation: Decodable, Hashable, LocationDataRepresentable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

extension CharacterLocation {
    static var emptyModel: Self {
        return CharacterLocation(
            id: .zero,
            name: "None",
            type: "Unknown",
            dimension: "None",
            residents: [],
            url: "",
            created: "")
    }
}
