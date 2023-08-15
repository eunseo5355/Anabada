//
//  SearchViewController.swift
//  Anabada
//
//  Created by 배은서 on 2023/08/14.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postTableView: UITableView!
    
    let dataManager = DataManager.shared
    var filteredPostData: [PostData] = []
    var postDataTitle: [String] = []
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchBar()
        
        for data in dataManager.postData {
            postDataTitle.append(data.title)
        }
    }
    
    func setTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
        
        let nib = UINib(nibName: PostTableViewCell.identifier, bundle: nil)
        postTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    func setSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredPostData.count : dataManager.postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell
        else { return UITableViewCell() }
        
        if isFiltering {
            cell.bind(filteredPostData[indexPath.row])
        } else {
            cell.bind(dataManager.postData[indexPath.row])
        }
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        postTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        filteredPostData = dataManager.postData.filter { $0.title.localizedCaseInsensitiveContains(text) }
        postTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text?.lowercased() else { return }
        filteredPostData = dataManager.postData.filter { $0.title.localizedCaseInsensitiveContains(text) }
        postTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isFiltering = false
        postTableView.reloadData()
    }
    
}
