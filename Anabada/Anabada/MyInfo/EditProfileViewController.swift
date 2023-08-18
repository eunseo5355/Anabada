//
//  EditProfileViewController.swift
//  Anabada
//
//  Created by 랑 on 2023/08/17.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var editedProfileImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var newNickName: UITextField!
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        setEditedImageView()
        rightBarButton()
    }
    
    private func setEditedImageView() {
        editedProfileImageView.image = UIImage(named: "룬")
        editedProfileImageView.contentMode = .scaleAspectFill
        editedProfileImageView.layer.cornerRadius = editedProfileImageView.frame.height/2
        editedProfileImageView.clipsToBounds = true
    }
    
    private func rightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        guard let newNickName = newNickName.text else { return }
        dataManager.myNickName = newNickName
        navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
    
}

extension EditProfileViewController: UINavigationControllerDelegate {
    
}
