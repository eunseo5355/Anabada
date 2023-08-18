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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEditedImageView()
        setCameraButtonLayer()
    }
    
    private func setEditedImageView() {
        editedProfileImageView.image = UIImage(named: "룬")
        editedProfileImageView.contentMode = .scaleAspectFill
        editedProfileImageView.layer.cornerRadius = editedProfileImageView.frame.height/2
        editedProfileImageView.clipsToBounds = true
    }
    
    private func setCameraButtonLayer() {
        //cameraButton.layer.cornerRadius = cameraButton.frame.height/2
    }
    
//    lazy var rightButton: UIBarButtonItem = {
//            let button = UIBarButtonItem(title: "RightBtn", style: .plain, target: self, action: #selector(buttonPressed(_:)))
//            button.tag = 2
//
//            return button
//        }()
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
    
}

extension EditProfileViewController: UINavigationControllerDelegate {
    
}
