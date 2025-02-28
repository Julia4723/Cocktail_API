//
//  ViewController.swift
//  Cocktail_API
//
//  Created by user on 24.02.2025.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellIdentifier = "cell"
    private let networkManager = NetworkManager.shared
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var filteredModel: [Model] = []
    var modelElement: [Model]?
    var query = String()
    var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellIdentifier)
        setupSearchController()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredModel.count : modelElement?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCell else {return UITableViewCell()}
        
        if let item = isFiltering ? filteredModel[indexPath.row] : modelElement?[indexPath.row] {
            cell.configure(model: item)
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}


extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else {
            filteredModel = []
            tableView.reloadData()
            return
        }
        
        networkManager.name = searchQuery
        networkManager.fetchAF { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.filteredModel = success
                    print("🔍 Найдено: \(success.count) элементов")
                case .failure(let error):
                    self?.filteredModel = []
                    print("❌ Ошибка поиска: \(error.localizedDescription)")
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredModel = modelElement?.filter{ model in
            model.name.lowercased().contains(searchText.lowercased())
        } ?? []
        print("🔍 Отфильтрованные элементы: \(filteredModel)")
        tableView.reloadData()
    }
}
