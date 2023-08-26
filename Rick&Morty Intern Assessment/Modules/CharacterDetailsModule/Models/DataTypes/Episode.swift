//
//  Episode.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 24.08.2023.
//

import Foundation

struct Episode: Codable, EpisodeDataRepresentable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
