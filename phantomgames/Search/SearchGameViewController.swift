//
//  SearchGameViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

class SearchGameViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    private lazy var viewModel = SearchGameViewModel(repository: SearchGameRepository(),
                                                     delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchSearchResults()
    }
    
    private func setupTableView() {
        tableView.register(CustomTableViewCell.tableViewNib(), forCellReuseIdentifier: Constants.TableViewIdentifiers.customCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TableView Delegate

extension SearchGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pageScreenSegue", sender: [indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.gameListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customCellIdentifier) as?
                CustomTableViewCell else {
            return UITableViewCell()
        }
        
        guard let game = viewModel.game(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setUpNib(title: game.title, genre: game.genre)
        cell.populateWith(game: game)
        return cell
    }
}

// MARK: - ViewModel Delegate

extension SearchGameViewController: ViewModelDelegate {
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
