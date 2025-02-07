//
//  VideoGameRepository.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Combine
import Foundation
import CoreData

protocol VideoGameRepositoryProtocol {
    func fetchGames() -> AnyPublisher<[VideoGameModel], Error>
    func saveGames(_ games: [VideoGameModel], context: NSManagedObjectContext)
    func loadGames(context: NSManagedObjectContext) -> [VideoGameModel]
}

class VideoGameRepository: VideoGameRepositoryProtocol {
    private let url = URL(string: "https://www.freetogame.com/api/games")!
    
    func fetchGames() -> AnyPublisher<[VideoGameModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [VideoGameModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .catch { error in
                Just([])
                    .setFailureType(to: Error.self)
            }
            .eraseToAnyPublisher()
    }
    
    func saveGames(_ games: [VideoGameModel], context: NSManagedObjectContext) {
        context.perform {
            games.forEach { game in
                let entity = VideoGameEntity(context: context)
                entity.id = Int32(Int64(game.id))
                entity.title = game.title
                entity.thumbnail = game.thumbnail
                entity.short_description = game.shortDescription
                entity.game_url = game.gameURL
                entity.genre = game.genre
                entity.platform = game.platform
                entity.publisher = game.publisher
                entity.developer = game.developer
                entity.release_date = game.releaseDate
                entity.freetogame_profile_url = game.profileURL
            }
            try? context.save()
        }
    }
    
    func loadGames(context: NSManagedObjectContext) -> [VideoGameModel] {
        let request: NSFetchRequest<VideoGameEntity> = VideoGameEntity.fetchRequest()
        let results = (try? context.fetch(request)) ?? []
        return results.map { entity in
            VideoGameModel(
                id: Int(entity.id),
                title: entity.title ?? "",
                thumbnail: entity.thumbnail ?? "",
                shortDescription: entity.short_description ?? "",
                gameURL: entity.game_url ?? "",
                genre: entity.genre ?? "",
                platform: entity.platform ?? "",
                publisher: entity.publisher ?? "",
                developer: entity.developer ?? "",
                releaseDate: entity.release_date ?? "",
                profileURL: entity.freetogame_profile_url ?? ""
            )
        }
    }
}
