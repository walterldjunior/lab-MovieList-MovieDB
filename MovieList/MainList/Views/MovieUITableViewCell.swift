//
//  MovieUITableViewCell.swift
//  MovieList
//
//  Created by Walter Junior on 29/05/26.
//

import UIKit
import SwiftUI

class MovieUITableViewCell: UITableViewCell {
    
    func setup(movie: MovieModel) {
        self.contentConfiguration = UIHostingConfiguration {
            MovieCellView(movie: movie)
        }
    }
}
