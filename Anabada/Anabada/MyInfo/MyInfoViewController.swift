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
    
    var dataManager = DataManager.shared
    let myNickName = "Anabada"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        nickNameLabel.text = myNickName
        
        editProfileBtn.setTitle("프로필 수정", for: .normal)
        editProfileBtn.setTitleColor(UIColor.black, for: .normal)
        editProfileBtn.layer.cornerRadius = 22.5
        editProfileBtn.layer.borderWidth = 1
        editProfileBtn.layer.borderColor = UIColor.systemGray4.cgColor
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
