//
//  HomeViewController.swift
//  Anabada
//
//  Created by 배은서 on 2023/08/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - 프로퍼티
    
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet var addNewPostButton: UIButton!
    
    private var dataManager = DataManager.shared
    
    @IBOutlet var menuButton: UIButton!
    
    private var state = "total"
    
    private var filterData:[PostData] = []
    
    // MARK: - viewController LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.filterData = self.dataManager.postData
        self.tableviewReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    // MARK: - SetUp Ui

    
    private func setUpUi() {
        makeNaviLeftButton()
        setUpAddNewPostButton()
        setUpTableView()

    }
    
    private func setUpTableView(){
        let nib = UINib(nibName: PostTableViewCell.identifier, bundle: nil)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    private func setUpAddNewPostButton() {
        addNewPostButton.setTitle("글쓰기", for: .normal)
        addNewPostButton.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
        addNewPostButton.layer.cornerRadius = 20
    }
    
    func tableviewReload(){
        UIView.transition(with: myTableView,duration: 0.5,options: .transitionCrossDissolve,animations: { self.myTableView.reloadData() })
    }
    

    // MARK: - button tap 메서드
    
    private func makeNaviLeftButton() {
        
        let total = UIAction(title: "전체", handler: { _ in
            self.state = "total"
            self.filterData = self.dataManager.postData
            self.menuButton.setTitle("전체", for: .normal)
            self.tableviewReload()
        })
        
        let borrow = UIAction(title: "필요해요", handler: { _ in
            self.state = "borrow"
            self.filterData = self.dataManager.postData.filter{$0.bigCategory == "필요해요"}
            self.menuButton.setTitle("필요해요", for: .normal)
            self.tableviewReload()
        })
        
        let lend = UIAction(title: "빌려드려요", handler: { _ in
            self.state = "lend"
            self.filterData = self.dataManager.postData.filter{$0.bigCategory == "빌려드려요"}
            self.menuButton.setTitle("빌려드려요", for: .normal)
            self.tableviewReload()
        })
        
        let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in })
        let menu = UIMenu(identifier: nil, options: .displayInline, children: [total, borrow, lend, cancel])
        
        menuButton.setTitle("전체", for: .normal)
        menuButton.menu = menu
    }
    
    
    @objc func addButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "AddPostViewController", sender: nil)
    }
    

    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return filterData.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return UITableViewCell() }
        cell.bind(filterData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        nextVC.bind(filterData[indexPath.row])
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
