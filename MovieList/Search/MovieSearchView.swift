//
//  MovieSearchView.swift
//  MovieList
//
//  Created by Walter Junior on 02/09/26.
//

import SwiftUI

struct MovieSearchView: View {
    
    @Bindable
    private var viewModel: MovieSearchViewModel
    @State
    private var query: String
    
    var onSelect: (_ movie: MovieModel) -> Void
    
    init(viewModel: MovieSearchViewModel = .init(), query: String = "", onSelect: @escaping (_ movie: MovieModel) -> Void) {
        self.viewModel = viewModel
        self.query = query
        self.onSelect = onSelect
    }
    
    @ViewBuilder
    private var searchTextField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Busque por filmes...", text: $query)
                .onSubmit({
                    self.viewModel.search(text: query)
                })
                .foregroundColor(.primary)
                .disableAutocorrection(true)
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var listView: some View {
        if query.isEmpty {
            Spacer()
            Text("Pesquise pelo título do filme...")
                .padding()
            Spacer()
        } else {
            List(viewModel.movies) { movie in
                Button {
                    self.onSelect(movie)
                } label: {
                    MovieCellView(movie: movie)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            searchTextField
            listView
            Spacer()
        }
        .navigationTitle("Busca")
    }
}
