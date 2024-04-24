//
//  SearchGameViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit
import SDWebImage

class SearchGameViewController: UIViewController {
   
    // MARK: - IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    private lazy var viewModel = SearchGameViewModel(repository: SearchGameRepository(),
                                                     delegate: self)
    // MARK: - UI Component
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchcontroller()
        viewModel.fetchSearchResults()
    }
    
    private func setupTableView() {
        tableView.register(CustomTableViewCell.tableViewNib(), forCellReuseIdentifier: Constants.TableViewIdentifiers.customCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setupSearchcontroller () {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Game title"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Search Controller Functions

extension SearchGameViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController)
    { self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text) }
}
// MARK: - TableView Delegate

extension SearchGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pageScreenSegue", sender: [indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredGames.count :
        self.viewModel.allGameList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     85
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customCellIdentifier) as?
                CustomTableViewCell else {
            return UITableViewCell()
        }
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        
        let game = inSearchMode ? self.viewModel.filteredGames[indexPath.row] :
        self.viewModel.allGameList[indexPath.row]
        
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
