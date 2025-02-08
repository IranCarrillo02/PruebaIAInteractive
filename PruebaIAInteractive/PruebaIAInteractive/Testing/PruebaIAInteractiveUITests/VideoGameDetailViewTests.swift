//
//  VideoGameDetailViewTests.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import XCTest

class VideoGameDetailViewTests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testEditButtonFunctionality() throws {
        let editButton = app.buttons["Editar"]
        XCTAssertTrue(editButton.exists, "El botón de editar debería existir")
        
        editButton.tap()
        
        let publisherField = app.textFields["Enter Publisher"]
        XCTAssertTrue(publisherField.exists, "El campo 'Publisher' debería estar disponible para edición")
        
        publisherField.tap()
        publisherField.typeText("Nintendo")
        
        XCTAssertEqual(publisherField.value as? String, "Nintendo", "El valor del campo 'Publisher' debería haber cambiado a 'Nintendo'")
    }
    
    func testSaveButtonFunctionality() throws {
        let editButton = app.buttons["Editar"]
        editButton.tap()
        
        let publisherField = app.textFields["Enter Publisher"]
        publisherField.tap()
        publisherField.typeText("Nintendo")
        
        let saveButton = app.buttons["Guardar"]
        XCTAssertTrue(saveButton.exists, "El botón de guardar debería existir")
        
        saveButton.tap()
        
        let updatedPublisher = app.staticTexts["Nintendo"]
        XCTAssertTrue(updatedPublisher.exists, "El juego debería tener el nuevo editor 'Nintendo'")
    }
    
    func testDeleteButtonFunctionality() throws {
        let deleteButton = app.buttons["Eliminar"]
        XCTAssertTrue(deleteButton.exists, "El botón de eliminar debería existir")
        
        deleteButton.tap()
        
        let backButton = app.buttons["chevron.left"]
        XCTAssertTrue(backButton.exists, "El botón de retroceder debería existir después de eliminar el juego")
    }
}
