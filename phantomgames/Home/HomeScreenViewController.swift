//
//  HomeScreenViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

class HomeScreenViewController: UIViewController{
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var HomeCollectionView: UICollectionView!
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: UI Components
    private lazy var viewModel = HomeScreenViewModel(repository: HomeScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchHomeResults()
    }
    private func setupTableView() {
        tableView.register(CustomHomeTableViewCell.HometableViewNib(), forCellReuseIdentifier: Constants.TableViewIdentifiers.customHomeCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCollectionView() {
        HomeCollectionView.dataSource = self
        HomeCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
}
// MARK:  Collection View

extension HomeScreenViewController: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.allGameList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CustomCollectionViewCell
        
        if let game = viewModel.game(atIndex: indexPath.item) {
            cell.ConfigCellWith(game: game)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){performSegue(withIdentifier: Constants.SegueIdentifiers.GameDetailScreenSegue, sender: indexPath)
    }
}

// MARK:  TableView Delegate

extension HomeScreenViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       viewModel.allGameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customHomeCellIdentifier) as? CustomHomeTableViewCell
        else {
            return UITableViewCell()
        }
        
        let game = viewModel.allGameList[indexPath.row]
        cell.populateWith(game: game)
        return cell
    }
}

// MARK:  ViewModel Delegate

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    
    func reloadView() {
        HomeCollectionView.reloadData()
        tableView.reloadData()
    }
    
    func show(error: String) {
        displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
