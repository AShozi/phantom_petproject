//
//  HomeScreenViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

class HomeScreenViewController: UIViewController{
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = HomeScreenViewModel(repository: HomeScreenRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchHomeResults()
    }
    private func setupTableView() {
        tableView.register(CustomTableViewCell.tableViewNib(), forCellReuseIdentifier: Constants.TableViewIdentifiers.customCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
    
    extension HomeScreenViewController: UICollectionViewDataSource{
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.allGameList.count
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CustomCollectionViewCell
            
            let game = viewModel.game(atIndex: indexPath.item)
            if let thumbnailURL = URL(string: game?.thumbnail ?? "" ) {
                       cell.apiImage.downloaded(from: thumbnailURL)
                   }
            cell.Gtitle.text = game?.title
            return cell
        }
    }
extension HomeScreenViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allGameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.customCellIdentifier) as? CustomTableViewCell
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
