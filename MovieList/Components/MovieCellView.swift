//
//  MovieCellView.swift
//  MovieList
//
//  Created by Walter Junior on 29/05/26.
//

import SwiftUI

struct MovieCellView: View {
    
    let movieTitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(.brown)
            Text(movieTitle)
                .lineLimit(2)
            Image(systemName: "chevron.right")
                .foregroundStyle(.brown)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

//#Preview {
//    MovieCellView(movieTitle: "Vingadores")
//}
