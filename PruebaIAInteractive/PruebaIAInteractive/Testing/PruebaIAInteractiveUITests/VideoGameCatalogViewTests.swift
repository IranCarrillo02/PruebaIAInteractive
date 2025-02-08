//
//  VideoGameCatalogViewTests.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import XCTest

class VideoGameCatalogViewTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSearchFunctionality() throws {
        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.exists, "El campo de búsqueda debería existir")
        
        searchField.tap()
        searchField.typeText("Super Mario")
        
        let gameTitle = app.staticTexts["Super Mario"]
        XCTAssertTrue(gameTitle.exists, "Debería aparecer el juego 'Super Mario' en los resultados de búsqueda")
    }
    
    func testGenreFiltering() throws {
        let genreButton = app.buttons["Action"]
        XCTAssertTrue(genreButton.exists, "El botón de género debería existir")
        
        genreButton.tap()
        
        let gameTitle = app.staticTexts["Call of Duty"]
        XCTAssertTrue(gameTitle.exists, "Debería aparecer un juego de acción como 'Call of Duty'")
    }
    
    func testGameDeletion() throws {
        let deleteButton = app.buttons["Eliminar"]
        XCTAssertTrue(deleteButton.exists, "El botón de eliminar debería existir")
        
        deleteButton.tap()
        
        let gameTitle = app.staticTexts["Super Mario"]
        XCTAssertFalse(gameTitle.exists, "El juego 'Super Mario' debería haberse eliminado")
    }
}
