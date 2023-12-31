//
//  SearchViewController.swift
//  Anabada
//
//  Created by 배은서 on 2023/08/14.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postTableView: UITableView!
    
    // MARK: - Properties
    
    let dataManager = DataManager.shared
    
    var filteredPostData: [PostData] = []
    var didFilter = false
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        postTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setSearchBar()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        filteredPostData = dataManager.postData
    }
    
    private func setTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
        
        let nib = UINib(nibName: PostTableViewCell.identifier, bundle: nil)
        postTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
    }

}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didFilter ? filteredPostData.count : dataManager.postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        if didFilter {
            cell.bind(filteredPostData[indexPath.row])
        } else {
            cell.bind(dataManager.postData[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.postData = filteredPostData[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            didFilter = false
        } else {
            didFilter = true
            guard let text = searchBar.text?.lowercased() else { return }
            filteredPostData = dataManager.postData.filter { $0.title.localizedCaseInsensitiveContains(text) }
        }
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
        didFilter = false
        postTableView.reloadData()
    }
    
}
