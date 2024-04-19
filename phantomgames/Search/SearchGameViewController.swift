import UIKit

class SearchGameViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
private lazy var viewModel = SearchGameViewModel(repository: SearchGameRepository(),
                                                      delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchSearchResults()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.tableViewNib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        //(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
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
        return viewModel.gameListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else { return UITableViewCell()
        }
        guard let game = viewModel.game(atIndex: indexPath.row) else {
            // preconditionFailure vs assertionFailure
            return UITableViewCell()
        }
        
        //code for displaying attribute on table , is it in the right place?
        cell.titleLabel.text = String(game.title)
        cell.genreLabel.text = String(game.genre)
        //table image using api thumbnail
        
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
