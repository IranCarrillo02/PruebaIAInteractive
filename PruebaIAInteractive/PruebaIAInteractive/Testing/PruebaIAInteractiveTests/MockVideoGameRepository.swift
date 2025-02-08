//
//  MockVideoGameRepository.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Foundation
import Combine
import CoreData

class MockVideoGameRepository: VideoGameRepositoryProtocol {
    
    var gamesToReturn: [VideoGameModel] = []
    var errorToReturn: Error? = nil
    
    func fetchGames() -> AnyPublisher<[VideoGameModel], Error> {
        if let error = errorToReturn {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(gamesToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func loadGames(context: NSManagedObjectContext) -> [VideoGameModel] {
        return gamesToReturn
    }
    
    func saveGames(_ games: [VideoGameModel], context: NSManagedObjectContext) {
        // Implementación vacía para las pruebas
    }
}
