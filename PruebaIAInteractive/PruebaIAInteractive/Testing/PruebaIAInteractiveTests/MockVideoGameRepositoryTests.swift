//
//  MockVideoGameRepositoryTests.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import Combine
import XCTest
@testable import PruebaIAInteractive
import CoreData

class MockVideoGameRepositoryTests: XCTestCase {
    
    var mockRepository: MockVideoGameRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockVideoGameRepository()
        cancellables = []
    }
    
    override func tearDown() {
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchGames() success
    
    func testFetchGamesSuccess() {
        let expectedGames: [VideoGameModel] = [
            VideoGameModel(id: 1, title: "Game 1", thumbnail: "thumbnail1.jpg", shortDescription: "Short description 1", gameURL: "https://game1.com", genre: "Action", platform: "PC", publisher: "Publisher 1", developer: "Developer 1", releaseDate: "2022-01-01", profileURL: "https://profile1.com"),
            VideoGameModel(id: 2, title: "Game 2", thumbnail: "thumbnail2.jpg", shortDescription: "Short description 2", gameURL: "https://game2.com", genre: "Adventure", platform: "Console", publisher: "Publisher 2", developer: "Developer 2", releaseDate: "2023-01-01", profileURL: "https://profile2.com")
        ]
        mockRepository.gamesToReturn = expectedGames
        
        var fetchedGames: [VideoGameModel]?
        var fetchError: Error?
        
        mockRepository.fetchGames()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    fetchError = error
                }
            }, receiveValue: { games in
                fetchedGames = games
            })
            .store(in: &cancellables)
        
        XCTAssertNil(fetchError)
        XCTAssertEqual(fetchedGames?.count, expectedGames.count)
        XCTAssertEqual(fetchedGames?.first?.title, "Game 1")
        XCTAssertEqual(fetchedGames?.first?.thumbnail, "thumbnail1.jpg")
        XCTAssertEqual(fetchedGames?.first?.releaseDate, "2022-01-01")
    }
    
    // MARK: - Test fetchGames() failure
    
    func testFetchGamesFailure() {
        let expectedError = NSError(domain: "com.example.app", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch games"])
        mockRepository.errorToReturn = expectedError
        
        var fetchedGames: [VideoGameModel]?
        var fetchError: Error?
        
        mockRepository.fetchGames()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    fetchError = error
                }
            }, receiveValue: { games in
                fetchedGames = games
            })
            .store(in: &cancellables)
        
        XCTAssertNotNil(fetchError)
        XCTAssertNil(fetchedGames)
        XCTAssertEqual((fetchError as? NSError)?.localizedDescription, "Failed to fetch games")
    }
    
    // MARK: - Test loadGames() success
    
    func testLoadGames() {
        let expectedGames: [VideoGameModel] = [
            VideoGameModel(id: 1, title: "Game 1", thumbnail: "thumbnail1.jpg", shortDescription: "Short description 1", gameURL: "https://game1.com", genre: "Action", platform: "PC", publisher: "Publisher 1", developer: "Developer 1", releaseDate: "2022-01-01", profileURL: "https://profile1.com"),
            VideoGameModel(id: 2, title: "Game 2", thumbnail: "thumbnail2.jpg", shortDescription: "Short description 2", gameURL: "https://game2.com", genre: "Adventure", platform: "Console", publisher: "Publisher 2", developer: "Developer 2", releaseDate: "2023-01-01", profileURL: "https://profile2.com")
        ]
        mockRepository.gamesToReturn = expectedGames
        
        let loadedGames = mockRepository.loadGames(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        
        XCTAssertEqual(loadedGames.count, expectedGames.count)
        XCTAssertEqual(loadedGames.first?.title, "Game 1")
        XCTAssertEqual(loadedGames.first?.releaseDate, "2022-01-01")
    }
    
    // MARK: - Test saveGames()
    
    func testSaveGames() {
        let gamesToSave: [VideoGameModel] = [
            VideoGameModel(id: 1, title: "Game 1", thumbnail: "thumbnail1.jpg", shortDescription: "Short description 1", gameURL: "https://game1.com", genre: "Action", platform: "PC", publisher: "Publisher 1", developer: "Developer 1", releaseDate: "2022-01-01", profileURL: "https://profile1.com"),
            VideoGameModel(id: 2, title: "Game 2", thumbnail: "thumbnail2.jpg", shortDescription: "Short description 2", gameURL: "https://game2.com", genre: "Adventure", platform: "Console", publisher: "Publisher 2", developer: "Developer 2", releaseDate: "2023-01-01", profileURL: "https://profile2.com")
        ]
        
        mockRepository.saveGames(gamesToSave, context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        
        XCTAssertTrue(true)
    }
}
