//
//  VideoGameViewModel.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Combine
import Foundation
import CoreData

class VideoGameViewModel: ObservableObject {
    @Published var games: [VideoGameModel] = []
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    private let repository: VideoGameRepositoryProtocol
    private let context: NSManagedObjectContext
    
    init(repository: VideoGameRepositoryProtocol = VideoGameRepository(), context: NSManagedObjectContext) {
        self.repository = repository
        self.context = context
        loadGames()
        fetchGames()
    }
    
    func fetchGames() {
        repository.fetchGames()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Error al cargar los juegos: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] games in
                self?.games = games
                self?.repository.saveGames(games, context: self!.context)
            })
            .store(in: &cancellables)
    }
    
    func loadGames() {
        games = repository.loadGames(context: context)
    }
}
