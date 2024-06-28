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
    private lazy var viewModel = SearchGameViewModel(repository: SearchGameRepository(), delegate: self)
    
    // MARK: UI Component
    private let searchController = UISearchController(searchResultsController: nil)
    
    var gamesURL: String?
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        loadResults()
    }
    
    func setUrl(gamesURL: String) {
        viewModel.setGameUrl(gamesURL: gamesURL)
    }
    
    private func loadResults() {
        if let url = viewModel.gamesURL {
            viewModel.fetchSearchResults(fromURL: url)
        } else {
            viewModel.fetchSearchResults()
        }
    }
    
    private func setupTableView() {
        tableView.register(CustomTableViewCell.tableViewNib(), forCellReuseIdentifier: Constants.TableViewIdentifiers.customCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
    }
    
    private func setupSearchController () {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = Constants.SearchConstants.searchBarPlaceholder
        // Customize search bar appearance
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .darkGray
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(
                string: Constants.SearchConstants.searchBarPlaceholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        }
        searchController.searchBar.barStyle = .black
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.searchBarStyle = .minimal
        
        if let backgroundView = searchController.searchBar.subviews.first?.subviews.first(where: { $0 is UITextField })?.superview {
            backgroundView.backgroundColor = .black
            backgroundView.layer.cornerRadius = 10
            backgroundView.clipsToBounds = true
        }
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func getSelectedGame(at index: Int) -> Game? {
        return viewModel.filteredGame(index: index,
                                      isSearchActive: searchController.isActive,
                                      searchText: searchController.searchBar.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifiers.GameDetailScreenSegue,
           let destinationVC = segue.destination as? GameDetailViewController,
           let gameID = sender as? Int {
            destinationVC.assignGameID(gameID: gameID)
        }
    }
}

// MARK: Search Controller Functions

extension SearchGameViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}

// MARK: TableView Delegate

extension SearchGameViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isSearchActive = searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        return isSearchActive ? viewModel.filteredGamesCount : viewModel.gameListCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customCellIdentifier) as?
                CustomTableViewCell else {
            return UITableViewCell()
        }
        if let newGame = getSelectedGame(at: indexPath.row) {
            cell.populateWith(game: newGame)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            displayAlert(title: "Error", message: "Failed to select game. Please try again.", buttonTitle: "OK")
            return
        }
        if let game = getSelectedGame(at: indexPath.row) {
            performSegue(withIdentifier: Constants.SegueIdentifiers.GameDetailScreenSegue, sender: game.gameID)
        }
    }
}

// MARK: ViewModel Delegate

extension SearchGameViewController: ViewModelDelegate {
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
