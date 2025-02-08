//
//  VideoGameModel.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Foundation

struct VideoGameModel: Identifiable, Codable {
    var id: Int
    var title: String
    var thumbnail: String
    var shortDescription: String
    var gameURL: String
    var genre: String
    var platform: String
    var publisher: String
    var developer: String
    var releaseDate: String
    var profileURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, genre, platform, publisher, developer
        case thumbnail, shortDescription = "short_description"
        case gameURL = "game_url"
        case releaseDate = "release_date"
        case profileURL = "freetogame_profile_url"
    }
}
