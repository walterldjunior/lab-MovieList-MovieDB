//
//  MainListViewModelProtocol.swift
//  MovieList
//
//  Created by Walter Junior on 01/06/26.
//

import Foundation

protocol MainListViewModelProtocol: AnyObject{
    var delegate: MainListViewModelDelegate? { get set }
    func loadData()
}
