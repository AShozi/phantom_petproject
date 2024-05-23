//
//  SearchGameViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit
import SDWebImage

class SearchGameViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    private lazy var viewModel = SearchGameViewModel(repository: SearchGameRepository(), delegate: self)
    // MARK: UI Component
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        viewModel.fetchSearchResults()
    }
    
    private func setupTableView() {
        tableView.register(CustomTableViewCell.tableViewNib(), forCellReuseIdentifier: Constants.TableViewIdentifiers.customCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setupSearchController () {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = Constants.SearchConstants.searchBarPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK:  Search Controller Functions

extension SearchGameViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController){
        viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}
// MARK:  TableView Delegate

extension SearchGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifiers.GameDetailScreenSegue, sender: [indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isSearchActive = searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        return isSearchActive ? viewModel.filteredGames.count : viewModel.allGameList.count    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customCellIdentifier) as?
                CustomTableViewCell else {
            return UITableViewCell()
        }
        let newGame = viewModel.filteredGame(index: indexPath.row,
                                                 isSearchActive: searchController.isActive,
                                                 searchText: searchController.searchBar.text)

        
        cell.populateWith(game: newGame)
        return cell
    }
}

// MARK:  ViewModel Delegate

extension SearchGameViewController: ViewModelDelegate {
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
