//
//  VideoGameCatalogView.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import SwiftUI
import CoreData

struct VideoGameCatalogView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: VideoGameViewModel
    @State private var searchText: String = ""
    @State private var activeGenre: String = "All"
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: VideoGameViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ExpandableNavigationBar(searchText: $searchText, activeGenre: $activeGenre, genres: viewModel.uniqueGenres(), games: viewModel.games)
                    
                    List(viewModel.filteredGames(searchText: searchText, genre: activeGenre)) { game in
                        NavigationLink(destination: VideoGameDetailView(game: game)) {
                            HStack(spacing: 12) {
                                CachedAsyncImage(url: URL(string: game.thumbnail))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(game.title)
                                        .font(.headline)
                                    Text(game.shortDescription)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onAppear {
                        viewModel.fetchGames()
                    }
                }
                
                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    ProgressView("Loading videogames...")
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
        }
    }
}
