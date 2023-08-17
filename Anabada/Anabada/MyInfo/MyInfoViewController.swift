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
    
    let myNickName = "룬"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageView()
        setButtonLayer()
        setSegmentedControl()
        setTableView()
        
        nickNameLabel.text = myNickName
    }
    
    private func setImageView() {
        imageView.image = UIImage(named: "룬")
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
        let myPostCount = dataManager.postData.filter { $0.nickName == myNickName }.count
        let myLikeCount = dataManager.postData.filter { $0.likeList.contains(myNickName) }.count
        segmentedControl.setTitle("나의 게시글 \(myPostCount)", forSegmentAt: 0)
        segmentedControl.setTitle("나의 좋아요 \(myLikeCount)", forSegmentAt: 1)
    }
    
    private func setTableView() {
        myPostTableView.delegate = self
        myPostTableView.dataSource = self
        
        let nib = UINib(nibName: PostTableViewCell.identifier, bundle: nil)
        myPostTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        
        filteredPostData = dataManager.postData.filter { $0.nickName == myNickName }
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        guard let editProfileViewController = UIStoryboard(name: "MyInfoViewController", bundle: .none).instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else { return }
        navigationController?.pushViewController(editProfileViewController, animated: true)
//        print("프로필 수정 버튼 클릭됨")
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            filteredPostData = dataManager.postData.filter { $0.nickName == myNickName }
            myPostTableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            filteredPostData = dataManager.postData.filter { $0.likeList.contains(myNickName) }
            myPostTableView.reloadData()
        }
    }
}

extension MyInfoViewController: UITableViewDelegate {
    
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



