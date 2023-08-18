//
//  EditProfileViewController.swift
//  Anabada
//
//  Created by 랑 on 2023/08/17.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var editedProfileImageView: UIImageView!
    @IBOutlet weak var newNickName: UITextField!
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        setEditedImageView()
        showRightBarButton()
    }
    
    private func setEditedImageView() {
        editedProfileImageView.image = UIImage(named: "룬")
        editedProfileImageView.contentMode = .scaleAspectFill
        editedProfileImageView.layer.cornerRadius = editedProfileImageView.frame.height/2
        editedProfileImageView.clipsToBounds = true
    }
    
    private func showRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        if let newNickName = newNickName.text, newNickName != "" {
            dataManager.myNickName = newNickName
        }
        navigationController?.popViewController(animated: true)
    }
}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func didPressCameraButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.editedProfileImageView.image = image
            dataManager.myProfileImage = image
        }
        dismiss(animated: true, completion: nil)
    }
}
