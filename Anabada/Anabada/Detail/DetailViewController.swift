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
    
    func bind(_ postData: PostData) {
        self.postData = postData
    }
    
}
