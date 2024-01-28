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
    let episodes: [String]
    let url: String
    let created: String
}

extension Character {
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender
        case origin, location, image, url, created
        case episode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(CharacterStatus.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decode(String.self, forKey: .type)
        gender = try container.decode(CharacterGender.self, forKey: .gender)
        origin = try container.decode(Origin.self, forKey: .origin)
        location = try container.decode(CharacterCurrentLocation.self, forKey: .location)
        image = try container.decode(String.self, forKey: .image)
        episodes = try container.decode([String].self, forKey: .episode)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(String.self, forKey: .created)
    }
}
