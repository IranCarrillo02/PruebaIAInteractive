//
//  ExpandableNavigationBar.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import SwiftUI

struct ExpandableNavigationBar: View {
    @Environment(\.colorScheme) private var scheme
    @FocusState private var isSearching: Bool
    @Namespace private var animation
    @Binding var searchText: String
    @Binding var activeGenre: String
    var title: String = "Game Catalog"
    var genres: [String]
    var games: [VideoGameModel]
    
    @State private var showSuggestions = false
    
    var filteredSuggestions: [String] {
        let gameTitles = games.map { $0.title }
        
        let allSuggestions = gameTitles
        return searchText.isEmpty ? [] : allSuggestions.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                
                TextField("Search Videogame", text: $searchText, onEditingChanged: { isEditing in
                    showSuggestions = isEditing
                })
                .focused($isSearching)
                
                if isSearching {
                    Button(action: {
                        searchText = ""
                        showSuggestions = false
                        isSearching = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.title3)
                    }
                    .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                }
            }
            .foregroundStyle(Color.primary)
            .padding(.vertical, 16)
            .padding(.horizontal, 15)
            .frame(height: 45)
            .clipShape(Capsule())
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.background)
                    .shadow(color: Color.gray.opacity(0.25), radius: 5, x: 0, y: 5)
            }

            if showSuggestions && !filteredSuggestions.isEmpty {
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(filteredSuggestions, id: \.self) { suggestion in
                            Button(action: {
                                searchText = suggestion
                                activeGenre = genres.contains(suggestion) ? suggestion : activeGenre
                                showSuggestions = false
                            }) {
                                Text(suggestion)
                                    .foregroundStyle(Color.primary)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
                .frame(height: filteredSuggestions.count <= 10 ?  (CGFloat(filteredSuggestions.count) * 25) : 150)
                .background(Color.clear)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(genres, id: \.self) { genre in
                        Button(action: {
                            withAnimation(.snappy) {
                                activeGenre = genre
                                searchText = ""
                                showSuggestions = false
                            }
                        }) {
                            Text(genre)
                                .font(.callout)
                                .foregroundStyle(activeGenre == genre ? (scheme == .dark ? .black : .white) : Color.primary)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background {
                                    if activeGenre == genre {
                                        Capsule()
                                            .fill(Color.primary)
                                            .matchedGeometryEffect(id: "ACTIVEGENRE", in: animation)
                                    } else {
                                        Capsule()
                                            .fill(.background)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding(.top, 25)
        .safeAreaPadding(.horizontal, 15)
    }
}
