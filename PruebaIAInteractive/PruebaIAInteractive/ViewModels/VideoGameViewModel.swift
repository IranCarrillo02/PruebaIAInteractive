//
//  VideoGameViewModel.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Combine
import Foundation

class VideoGameViewModel: ObservableObject {
    @Published var games: [VideoGameModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let videoGameRepository: VideoGameRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(videoGameRepository: VideoGameRepositoryProtocol = VideoGameRepository()) {
        self.videoGameRepository = videoGameRepository
    }

    func fetchGames() {
        isLoading = true
        videoGameRepository.fetchGames()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
}
