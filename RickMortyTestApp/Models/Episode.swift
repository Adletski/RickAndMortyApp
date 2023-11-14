//
//  Episode.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import Foundation

struct Episode: Codable {
    let info: Info
    var results: [Res]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String
}

struct Res: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
