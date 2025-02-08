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
            VStack {
                ExpandableNavigationBar(searchText: $searchText, activeGenre: $activeGenre, genres: viewModel.uniqueGenres(), games: viewModel.games)
                
                List {
                    ForEach(viewModel.filteredGames(searchText: searchText, genre: activeGenre)) { game in
                        NavigationLink(destination: VideoGameDetailView(viewModel: viewModel, game: $viewModel.games[viewModel.games.firstIndex(where: { $0.id == game.id })!])) {
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
                    }
                    .onDelete(perform: viewModel.deleteGame)
                    .listRowSeparator(.hidden)
                }
                .onAppear {
                    viewModel.fetchGames()
                }
            }
        }
    }
}
