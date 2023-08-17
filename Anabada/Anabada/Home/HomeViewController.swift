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
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        setUpUi()
        self.navigationController?.navigationBar.topItem?.title = ""
        let nib = UINib(nibName: PostTableViewCell.identifier, bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    private func setUpUi() {
        makeNaviLeftButton(state: "전체")
        setUpAddNewPostButton()
    }
    
    private func setUpAddNewPostButton() {
        addNewPostButton.setTitle("글쓰기", for: .normal)
        addNewPostButton.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
        addNewPostButton.layer.cornerRadius = 20
    }
    
    private func makeNaviLeftButton(state:String) {
        
        let total = UIAction(title: "전체", handler: { _ in
            self.state = "total"
            self.myTableView.reloadData()
            self.makeNaviLeftButton(state: "전체")
            self.menuButtonDownAnimate(sender: self.menuButton)
        })
        
        let borrow = UIAction(title: "필요해요", handler: { _ in
            self.state = "borrow"
            self.myTableView.reloadData()
            self.makeNaviLeftButton(state: "필요해요")
            self.menuButtonDownAnimate(sender: self.menuButton)
        })
        
        let lend = UIAction(title: "빌려드려요", handler: { _ in
            self.state = "lend"
            self.myTableView.reloadData()
            self.makeNaviLeftButton(state: "빌려드려요")
            self.menuButtonDownAnimate(sender: self.menuButton)
        })
        
        let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in
            self.menuButtonDownAnimate(sender: self.menuButton)
        })
        let menu = UIMenu(identifier: nil, options: .displayInline, children: [total, borrow, lend, cancel])

        menuButton.setTitle(state, for: .normal)
        var newSize = menuButton.intrinsicContentSize
        newSize.width += 10
        menuButton.frame.size = newSize
        menuButton.addTarget(self, action: #selector(menuButtonTapped(sender:)), for: .touchDown)
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "AddPostViewController", sender: nil)
    }
    
    @objc func menuButtonTapped(sender: UIButton) {
        menuButtonUpAnimate(sender: menuButton)
    }
    
    private func menuButtonDownAnimate(sender: UIButton) {
        UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }, completion: nil)
    }
    
    private func menuButtonUpAnimate(sender: UIButton) {
        UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromTop, animations: {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {

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
}
