//
//  DetailViewcontroller.swift
//  Anabada
//
//  Created by 손영하  on 2023/08/18.
//

import UIKit


class DetailViewController: UIViewController {
    
    var postData: PostData?
    
    var dataManager = DataManager.shared
    
    @IBOutlet var postImage: UIImageView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var nickNameLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentTextView: UITextView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    func setUpUi(){
        
        var target = postData?.nickName
        self.profileImage?.image = dataManager.userData.filter{$0.nickName == target}[0].profileImage
        self.postImage.image = postData?.image
        self.nickNameLabel.text = postData?.nickName
        self.titleLabel.text = postData?.title
        self.contentTextView.text = postData?.content
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
    }
    
    func bind(_ postData: PostData) {
        self.postData = postData
    }
}
