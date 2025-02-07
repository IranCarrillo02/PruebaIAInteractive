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
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: VideoGameViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.games) { game in
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
            }
            .navigationTitle("Game Catalog")
            .onAppear {
                viewModel.fetchGames()
            }
        }
    }
}
