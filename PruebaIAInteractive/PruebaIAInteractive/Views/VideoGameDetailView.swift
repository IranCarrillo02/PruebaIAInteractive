//
//  VideoGameDetailView.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import SwiftUI

struct VideoGameDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: VideoGameViewModel
    @State private var isEditing = false
    @State private var updatedPublisher: String
    @State private var updatedPlatform: String
    @State private var updatedDeveloper: String
    @State private var updatedReleaseDate: String

    @Binding var game: VideoGameModel
    
    init(viewModel: VideoGameViewModel, game: Binding<VideoGameModel>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _updatedPublisher = State(initialValue: game.wrappedValue.publisher)
        _updatedPlatform = State(initialValue: game.wrappedValue.platform)
        _updatedDeveloper = State(initialValue: game.wrappedValue.developer)
        _updatedReleaseDate = State(initialValue: game.wrappedValue.releaseDate)
        _game = game
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CachedAsyncImage(url: URL(string: game.thumbnail))
                    .padding(.vertical, 16)
                    .frame(height: 280)
                    .shadow(color: .gray, radius: 8, x: 0, y: 4)

                Text(game.shortDescription)
                    .font(.body)
                    .padding(.top, 4)
                
                // Edición solo si estamos en modo edición
                if isEditing {
                    VStack(alignment: .leading) {
                        Text("Publisher:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        TextField("Enter Publisher", text: $updatedPublisher)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Platform:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        TextField("Enter Platform", text: $updatedPlatform)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Developer:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        TextField("Enter Developer", text: $updatedDeveloper)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Release Date:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        TextField("Enter Release Date", text: $updatedReleaseDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 8)
                    }
                } else {
                    // Solo mostrar los datos cuando no estamos en modo edición
                    VStack(alignment: .leading) {
                        Text("Genre:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(game.genre)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Platform:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(game.platform)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Publisher:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(game.publisher)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Developer:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(game.developer)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Release Date:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(game.releaseDate)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }

                Link("Visit Game Website", destination: URL(string: game.gameURL)!)
                    .padding(.top, 16)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
            },
            trailing: HStack {
                Button(action: {
                    isEditing.toggle()
                    if !isEditing {
                        // Actualizamos los datos en el ViewModel y las variables locales
                        viewModel.updateGame(game: game, publisher: updatedPublisher, platform: updatedPlatform, developer: updatedDeveloper, releaseDate: updatedReleaseDate)
                        
                        // Actualizamos las variables locales con los valores editados
                        game.publisher = updatedPublisher
                        game.platform = updatedPlatform
                        game.developer = updatedDeveloper
                        game.releaseDate = updatedReleaseDate
                    }
                }) {
                    Text(isEditing ? "Guardar" : "Editar")
                        .font(.callout)
                        .foregroundStyle(isEditing ? Color.green : Color.blue)
                }

                Button(action: {
                    if let index = viewModel.games.firstIndex(where: { $0.id == game.id }) {
                        viewModel.deleteGame(at: IndexSet([index]))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Eliminar")
                        .font(.callout)
                        .foregroundStyle(Color.red)
                }
            }
        )
    }
}
