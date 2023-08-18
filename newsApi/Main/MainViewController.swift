//
//  MainViewController.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = MainViewModel()
    var categories  = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.loadCategories { result in
            self.categories = result
            self.tableView.reloadData()
        }

    }
    
    func goToSourceViewController(category: String) {
        let destination = SourceViewController()
        destination.setCategory(category: category)
        navigationController?.pushViewController(destination, animated: true)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell

        let category = categories[indexPath.row]
        cell.configure(text: category)

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        goToSourceViewController(category: category)
    }
}

