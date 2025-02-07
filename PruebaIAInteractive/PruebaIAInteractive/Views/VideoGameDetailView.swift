//
//  VideoGameDetailView.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import SwiftUI

struct VideoGameDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let game: VideoGameModel
    
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
                
                Link("Visit Game Website", destination: URL(string: game.gameURL)!)
                    .padding(.top, 16)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color.black)
        })
    }
}
