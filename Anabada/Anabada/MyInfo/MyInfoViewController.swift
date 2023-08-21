//
//  MyInfoViewController.swift
//  Anabada
//
//  Created by 배은서 on 2023/08/14.
//

import UIKit

class MyInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var myPostTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let dataManager = DataManager.shared
    
    var filteredPostData: [PostData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        configureViewWillAppear()
        nickNameLabel.text = dataManager.myInfo.nickName
        imageView.image = dataManager.myInfo.profileImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageView()
        setButtonLayer()
        setSegmentedControl()
        setTableView()
        touchUpBackButton()
    }
    
    // MARK: - Helpers
    
    private func configureViewWillAppear() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    
    private func setButtonLayer() {
        editProfileBtn.layer.cornerRadius = 22.5
        editProfileBtn.layer.borderWidth = 1
        editProfileBtn.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    private func setSegmentedControl() {
        let myPostCount = dataManager.postData.filter { $0.nickName == dataManager.myInfo.nickName }.count
        let myLikeCount = dataManager.postData.filter { $0.likeList.contains(dataManager.myInfo.nickName) }.count
        segmentedControl.setTitle("나의 게시글 \(myPostCount)", forSegmentAt: 0)
        segmentedControl.setTitle("나의 좋아요 \(myLikeCount)", forSegmentAt: 1)
    }
    
    private func setTableView() {
        myPostTableView.delegate = self
        myPostTableView.dataSource = self
        
        let nib = UINib(nibName: PostTableViewCell.identifier, bundle: nil)
        myPostTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        
        filteredPostData = dataManager.postData.filter { $0.nickName == dataManager.myInfo.nickName }
    }
    
    private func touchUpBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.backBarButtonItem?.tintColor = .systemGreen
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        guard let editProfileViewController = UIStoryboard(name: "MyInfoViewController", bundle: .none).instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else { return }
//        editProfileViewController.changeNickNameCallBack = { [weak self] in
//            guard let self else { return }
//            nickNameLabel.text = dataManager.myInfo.nickName
//        }
//        editProfileViewController.changeProfileImageCallBack = { [weak self] in
//            guard let self else { return }
//            imageView.image = dataManager.myInfo.profileImage
//        }
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            filteredPostData = dataManager.postData.filter { $0.nickName == dataManager.myInfo.nickName }
            myPostTableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            filteredPostData = dataManager.postData.filter { $0.likeList.contains(dataManager.myInfo.nickName) }
            myPostTableView.reloadData()
        }
    }

}

extension MyInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "DetailStoryboard", bundle: .none).instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.bind(filteredPostData[indexPath.row])
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPostTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell
        else { return UITableViewCell() }
        
        cell.bind(filteredPostData[indexPath.row])
        
        return cell
    }
    
}



