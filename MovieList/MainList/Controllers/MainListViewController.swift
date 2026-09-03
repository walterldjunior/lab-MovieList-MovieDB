//
//  MainListViewController.swift
//  MovieList
//
//  Created by Walter Junior on 29/05/26.
//

import UIKit
import SwiftUI

class MainListViewController: UIViewController {
    
    let viewModel: MainListViewModelProtocol
    var listMovies: [MovieModel] = []
    
    // MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie List"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieUITableViewCell.self, forCellReuseIdentifier: "MovieCellView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: MainListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func loadView() {
        super .loadView()
        view.backgroundColor = .brown
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupSearchNavigationItem()
    }
    
    // MARK: - Methods
    
    func loadData() {
        Task {
            do {
                self.listMovies = try await viewModel.loadData()
                tableView.reloadData()
            } catch {
                // TODO: Criar alerta de erro
            }
        }
    }
    
    func setupSearchNavigationItem() {
        let searchButton = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(actionSearch)
        )
        navigationItem.rightBarButtonItems = [searchButton]
    }
    
    @objc func actionSearch() {
        let viewController = UIHostingController(
            rootView: MovieSearchView(
                onSelect: { [weak self] movie in
                    guard let self = self else { return }
//                    self.navigateToDetailView(movie)
                }
            )
        )
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - TableView Delegate
}

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellView", for: indexPath) as! MovieUITableViewCell
        cell.setup(movie: listMovies[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        titleLabel.text = listMovies[indexPath.row].title
    }
}
