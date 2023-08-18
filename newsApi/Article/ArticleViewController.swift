//
//  ArticleViewController.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import UIKit

class ArticleViewController: UIViewController, UISearchResultsUpdating{
    
    var source = ""
    var articles = [Article]()
    var viewModel = ArticleViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsCardCell", bundle: nil), forCellReuseIdentifier: "NewsCardCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.loadArticle(source: source) { result in
            self.articles = result
            self.tableView.reloadData()
        }

        
        title = "Article News"
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
    }
    
    func setSource(source: String) {
        title = source
        self.source = source
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        viewModel.searchArticle(source: source, keyword: text) { result in
            self.articles = result
            self.tableView.reloadData()
        }
    }
    
    func goToWebViewController(articleUrl: String) {
        let destination = WebviewViewController()
        destination.setArticleUrl(articleUrl: articleUrl)
        navigationController?.pushViewController(destination, animated: true)
    }
    
}

extension ArticleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCardCell", for: indexPath) as! NewsCardCell
        
        let article = articles[indexPath.row]
        cell.configure(title: article.title, publishedAt: article.publishedAt, urlToImage: article.urlToImage)
        
        return cell
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        goToWebViewController(articleUrl: article.url ?? "")
    }
    
}
