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
}

class VideoGameRepository: VideoGameRepositoryProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchGames() -> AnyPublisher<[VideoGameModel], Error> {
        let url = URL(string: "https://www.freetogame.com/api/games")!
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [VideoGameModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension VideoGameRepository {
    func saveGamesToCoreData(_ videoGames: [VideoGameModel]) {
        let context = CoreDataManager.shared.context
        videoGames.forEach { videoGames in
            let videoGameEntity = VideoGameEntity(context: context)
            videoGameEntity.id = Int32(videoGames.id)
            videoGameEntity.title = videoGames.title
            videoGameEntity.thumbnail = videoGames.thumbnail
            videoGameEntity.short_description = videoGames.shortDescription
            videoGameEntity.game_url = videoGames.gameUrl
            videoGameEntity.genre = videoGames.genre
            videoGameEntity.platform = videoGames.platform
            videoGameEntity.publisher = videoGames.publisher
            videoGameEntity.developer = videoGames.developer
            videoGameEntity.release_date = videoGames.releaseDate
            videoGameEntity.freetogame_profile_url = videoGames.freetogameProfileUrl
        }
        CoreDataManager.shared.saveContext()
    }

    func fetchGamesFromCoreData() -> [VideoGameModel] {
        let fetchRequest: NSFetchRequest<VideoGameEntity> = VideoGameEntity.fetchRequest()
        let context = CoreDataManager.shared.context
        do {
            let videoGameEntities = try context.fetch(fetchRequest)
            return videoGameEntities.map { VideoGameModel(id: Int($0.id), title: $0.title ?? "", thumbnail: $0.thumbnail ?? "", shortDescription: $0.short_description ?? "", gameUrl: $0.game_url ?? "", genre: $0.genre ?? "", platform: $0.platform ?? "", publisher: $0.publisher ?? "", developer: $0.developer ?? "", releaseDate: $0.release_date ?? "", freetogameProfileUrl: $0.freetogame_profile_url ?? "")
            }
        } catch {
            return []
        }
    }
}
