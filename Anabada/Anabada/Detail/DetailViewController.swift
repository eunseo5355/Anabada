//
//  DetailViewcontroller.swift
//  Anabada
//
//  Created by 손영하  on 2023/08/18.
//

import UIKit


class DetailViewController: UIViewController {
    
    var postData: PostData?
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var contentsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func bind(_ postData: PostData) {
        postImage.image = postData.image
        nickNameLabel.text = postData.nickName
        titleLabel.text = postData.title
        //           heartButton.UIButton = postData.UIButton//
        contentsTextView.text = "\(postData.content)"
        
        
    }
    
}
