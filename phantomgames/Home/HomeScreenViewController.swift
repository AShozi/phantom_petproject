//
//  HomeScreenViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var homeCollectionView: UICollectionView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var pcImage: UIImageView!
    @IBOutlet weak private var browserImage: UIImageView!
    @IBOutlet weak private var spinner: UIActivityIndicatorView!
    
    // MARK: UI Components
    private lazy var viewModel = HomeScreenViewModel(repository: HomeScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
    }
    
    private func setUpController() {
        setupTableView()
        setupCollectionView()
        setupGestureRecognizers()
        viewModel.fetchCollectionViewGames()
        viewModel.fetchTableViewGames()
    }
    
    private func setupTableView() {
        tableView.register(CustomHomeTableViewCell.hometableViewNib(),
                           forCellReuseIdentifier: Constants.TableViewIdentifiers.customHomeCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCollectionView() {
        homeCollectionView.dataSource = self
        homeCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    
    private func setupGestureRecognizers() {
        let pcTapGesture = UITapGestureRecognizer(target: self, action: #selector(pcImageTapped))
        pcImage.isUserInteractionEnabled = true
        pcImage.addGestureRecognizer(pcTapGesture)
        
        let browserTapGesture = UITapGestureRecognizer(target: self, action: #selector(browserImageTapped))
        browserImage.isUserInteractionEnabled = true
        browserImage.addGestureRecognizer(browserTapGesture)
    }
    
    private func navigateToSearchGameScreen(with url: String) {
        let storyboard = UIStoryboard(name: "SearchGame", bundle: nil)
        if let searchGameViewController = storyboard.instantiateViewController(withIdentifier: "SearchGameViewController") as?
            SearchGameViewController {
            searchGameViewController.setUrl(gamesURL: url)
            navigationController?.pushViewController(searchGameViewController, animated: true)
        }
    }
    
    @objc
    private func pcImageTapped() {
        navigateToSearchGameScreen(with: Constants.Endpoints.pcGamesURL)
    }
    
    @objc
    private func browserImageTapped() {
        navigateToSearchGameScreen(with: Constants.Endpoints.browserGamesURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifiers.GameDetailScreenSegue,
           let destinationVC = segue.destination as? GameDetailViewController,
           let gameID = sender as? Int {
            destinationVC.assignGameID(gameID: gameID)
        }
    }
}

// MARK: Collection View

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionViewGamesCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let game = viewModel.collectionViewGame(atIndex: indexPath.item) {
            cell.configCellWith(game: game)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell,
              let gameID = viewModel.collectionViewGame(atIndex: indexPath.item)?.gameID else {
            displayAlert(title: "Error", message: "Failed to select game. Please try again.", buttonTitle: "OK")
            return
        }
        performSegue(withIdentifier: Constants.SegueIdentifiers.GameDetailScreenSegue, sender: gameID)
    }
    
}

// MARK: TableView Delegate

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableViewGamesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customHomeCellIdentifier) as?
                CustomHomeTableViewCell
        else {
            return UITableViewCell()
        }
        let game = viewModel.allGameList[indexPath.row]
        cell.populateWith(game: game)
        return cell
    }
}

// MARK: ViewModel Delegate

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    
    // MARK: functions
    
    func reloadView() {
        homeCollectionView.reloadData()
        tableView.reloadData()
    }
    
    func reloadCollectionView() {
        homeCollectionView.reloadData()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}
