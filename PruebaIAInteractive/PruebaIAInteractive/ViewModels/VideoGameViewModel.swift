//
//  VideoGameViewModel.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Combine
import Foundation
import CoreData
import SwiftUI

class VideoGameViewModel: ObservableObject {
    @Published var games: [VideoGameModel] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let repository: VideoGameRepositoryProtocol
    private let context: NSManagedObjectContext
    
    init(repository: VideoGameRepositoryProtocol = VideoGameRepository(), context: NSManagedObjectContext) {
        self.repository = repository
        self.context = context
    }
    
    func fetchGames() {
        let existingGames = repository.loadGames(context: context)

        if existingGames.isEmpty { // Si Core Data está vacío, llama a la API
            isLoading = true
            repository.fetchGames()
                .sink(receiveCompletion: { completion in
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.errorMessage = "Error al cargar los juegos: \(error.localizedDescription)"
                        }
                    }
                }, receiveValue: { [weak self] games in
                    DispatchQueue.main.async {
                        self?.games = games
                        self?.repository.saveGames(games, context: self!.context)
                    }
                })
                .store(in: &cancellables)
        } else {
            games = existingGames
        }
    }
    
    func loadGames() {
        DispatchQueue.main.async {
            let loadedGames = self.repository.loadGames(context: self.context)
            print("Juegos cargados desde Core Data:", loadedGames.map { $0.title })
            self.games = loadedGames
        }
    }
    
    func filteredGames(searchText: String, genre: String) -> [VideoGameModel] {
        games.filter { game in
            (searchText.isEmpty || game.title.localizedCaseInsensitiveContains(searchText)) &&
            (genre == "All" || game.genre.trimmingCharacters(in: .whitespaces) == genre.trimmingCharacters(in: .whitespaces))
        }
    }
    
    func uniqueGenres() -> [String] {
        let genres = Set(games.map { $0.genre.trimmingCharacters(in: .whitespaces) })
        return ["All"] + genres.sorted()
    }
    
    func deleteGame(at offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                let game = games[index]
                
                let fetchRequest: NSFetchRequest<VideoGameEntity> = VideoGameEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", game.id as CVarArg)
                
                do {
                    let results = try context.fetch(fetchRequest)
                    print("Antes de eliminar: \(results.count) juegos encontrados en Core Data")
                    
                    if let gameEntity = results.first {
                        context.delete(gameEntity)
                        try context.save()
                    } else {
                        print("No se encontró el juego en Core Data")
                    }
                } catch {
                    print("Error eliminando juego: \(error.localizedDescription)")
                }
            }
            
            games.remove(atOffsets: offsets)
            fetchGames()
        }
    }
    
    func updateGame(game: VideoGameModel, publisher: String, platform: String, developer: String, releaseDate: String) {
        let fetchRequest: NSFetchRequest<VideoGameEntity> = VideoGameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", game.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let gameEntity = results.first {
                gameEntity.publisher = publisher
                gameEntity.platform = platform
                gameEntity.developer = developer
                gameEntity.release_date = releaseDate
                
                try context.save()
            } else {
                print("No se encontró el juego en Core Data para actualizar")
            }
        } catch {
            print("Error actualizando juego: \(error.localizedDescription)")
        }
    }
}
