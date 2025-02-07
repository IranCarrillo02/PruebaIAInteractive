//
//  VideoGameModel.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Foundation

struct VideoGameModel: Identifiable, Codable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let profileURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, genre, platform, publisher, developer
        case thumbnail, shortDescription = "short_description"
        case gameURL = "game_url"
        case releaseDate = "release_date"
        case profileURL = "freetogame_profile_url"
    }
}
