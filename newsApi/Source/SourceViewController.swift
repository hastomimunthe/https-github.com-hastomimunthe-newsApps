//
//  SourceViewController.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import UIKit


class SourceViewController: UIViewController, UISearchResultsUpdating{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var errorLabel: UILabel!
    

    var category = ""
    var sources = [SourceResponse]()
    var viewModel = SourceViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        
        tableView.register(UINib(nibName: "TitleDescriptionCell", bundle: nil), forCellReuseIdentifier: "TitleDescriptionCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.loadSources(category: category) { result in
            switch result {
            case let .success(data):
                self.errorLabel.isHidden = true
                self.sources = data
            case .failure:
                self.errorLabel.isHidden = false
            }
            self.tableView.reloadData()
        }
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        viewModel.searchSource(keyword: text) { result in
            self.sources = result
            self.tableView.reloadData()
        }
    }
    
    func goToArticleViewController(source: String) {
        let destination = ArticleViewController()
        destination.setSource(source: source)
        navigationController?.pushViewController(destination, animated: true)
    }


    func setCategory(category: String) {
        title = category
        self.category = category
    }
    
    
}

extension SourceViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleDescriptionCell", for: indexPath) as! TitleDescriptionCell
        let source = sources[indexPath.row]
        cell.configure(title: source.name, description: source.description)
        
        return cell
    }
}

extension SourceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let source = sources[indexPath.row]
        goToArticleViewController(source: source.id ?? "")
    }
}
