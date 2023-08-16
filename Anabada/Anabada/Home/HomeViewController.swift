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
    
    var dataManager = DataManager.shared
    
    @IBOutlet var leftButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        setUpUi()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setUpUi() {
        makeNaviLeftButton()
        setUpAddNewPostButton()
    }
    
    func setUpAddNewPostButton() {
        addNewPostButton.setTitle("글쓰기", for: .normal)
        addNewPostButton.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
        addNewPostButton.layer.cornerRadius = 20
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "AddPostViewController", sender: nil)
        print("hi")
    }
    
    func makeNaviLeftButton() {
        let total = UIAction(title: "전체", handler: { _ in print("전체Tapped") })
        let borrow = UIAction(title: "필요해요", handler: { _ in print("필요해요Tapped") })
        let lend = UIAction(title: "빌려드려요", handler: { _ in print("빌려드려요Tapped") })
        let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소") })
        let menu = UIMenu(image: UIImage(systemName: "heart.fill"), identifier: nil, options: .displayInline, children: [total, borrow, lend, cancel])

        leftButton.menu = menu
        leftButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        leftButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        leftButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        leftButton.showsMenuAsPrimaryAction = true
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath)
        return cell
    }
}
