//
//  HomeViewController.swift
//  Anabada
//
//  Created by 배은서 on 2023/08/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet var addNewPostButton: UIButton!
    
    private var dataManager = DataManager.shared
    
    @IBOutlet var menuButton: UIButton!
    
    private var state = "total"
    
    private var choiceId = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableviewReload()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
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
    
    private func makeNaviLeftButton() {
        
        let total = UIAction(title: "전체", handler: { _ in
            self.state = "total"
            self.tableviewReload()
            self.menuButton.setTitle("전체", for: .normal)
        })
        
        let borrow = UIAction(title: "필요해요", handler: { _ in
            self.state = "borrow"
            self.tableviewReload()
            self.menuButton.setTitle("필요해요", for: .normal)
        })
        
        let lend = UIAction(title: "빌려드려요", handler: { _ in
            self.state = "lend"
            self.tableviewReload()
            self.menuButton.setTitle("빌려드려요", for: .normal)
        })
        
        let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in })
        let menu = UIMenu(identifier: nil, options: .displayInline, children: [total, borrow, lend, cancel])
        
        menuButton.setTitle("전체", for: .normal)
        menuButton.menu = menu
    }
    
    
    @objc func addButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "AddPostViewController", sender: nil)
    }
    
    func tableviewReload(){
        UIView.transition(with: myTableView,duration: 0.5,options: .transitionCrossDissolve,animations: { self.myTableView.reloadData() })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == "borrow"{
            return dataManager.postData.filter{$0.bigCategory == "필요해요"}.count
        } else if state == "lend"{
            return dataManager.postData.filter{$0.bigCategory == "빌려드려요"}.count
        } else {
            return dataManager.postData.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return UITableViewCell() }
        if state == "borrow"{
            cell.bind(dataManager.postData.filter{$0.bigCategory == "필요해요"}[indexPath.row])
        } else if state == "lend"{
            cell.bind(dataManager.postData.filter{$0.bigCategory == "빌려드려요"}[indexPath.row])
        } else {
            cell.bind(dataManager.postData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.post
        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
}
