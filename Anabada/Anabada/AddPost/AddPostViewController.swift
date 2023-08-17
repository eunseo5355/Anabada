//
//  AddPostViewController.swift
//  Anabada
//
//  Created by SeoJunYoung on 2023/08/14.
//

import UIKit

class AddPostViewController: UIViewController {
    
    
    
    @IBOutlet var borrow: UIButton!
    
    @IBOutlet var lend: UIButton!
    
    var dataManager = DataManager.shared
    
    var buttonToggle = true
    
    var doneButtonToggle = false
    
    var nowTextView = 0
    
    var choiceImage = UIImage(systemName: "photo")
    
    @IBOutlet var titleTrailingView: UIView!
    
    @IBOutlet var titleTextView: UITextView!
    
    @IBOutlet var contentTrailingView: UIView!
    
    @IBOutlet var contentTextView: UITextView!
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var imageAddButton: UIButton!
    
    private let picker = UIImagePickerController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(notification:NSNotification) {
        if nowTextView == 0{
            
        } else {
            if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

                let keyboardRectangle = keyboardFrame.cgRectValue

                UIView.animate(withDuration: 0.3, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height + 100)
                })
            }
        }
    }
    
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    private func setUpUi(){
        picker.delegate = self
        titleTextView.delegate = self
        contentTextView.delegate = self
        image.layer.cornerRadius = 20
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
        setUpButton(state:buttonToggle)
        setUpTrailingView()
    }
    
    private func setUpButton(state:Bool){
        
        borrow.layer.borderWidth = 1
        borrow.layer.borderColor = UIColor.systemGreen.cgColor
        borrow.layer.cornerRadius = 15
        lend.layer.borderWidth = 1
        lend.layer.borderColor = UIColor.systemGreen.cgColor
        lend.layer.cornerRadius = 15
        imageAddButton.layer.borderWidth = 1
        imageAddButton.layer.borderColor = UIColor.systemGreen.cgColor
        imageAddButton.layer.cornerRadius = 15
        
        UIView.animate(withDuration: 0.3){
            self.borrow.backgroundColor = state == true ? .systemGreen : .clear
            self.borrow.tintColor = state == true ? .white : .gray
            self.lend.backgroundColor = state == true ? .clear : .systemGreen
            self.lend.tintColor = state == true ? .gray : .white
            self.doneButton.tintColor = self.doneButtonToggle ? UIColor.systemGreen : UIColor.systemGray5
        }
        
        borrow.addTarget(self, action: #selector(borrowButtonTapped(sender:)), for: .touchUpInside)
        lend.addTarget(self, action: #selector(lendButtonTapped(sender:)), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonTapped(sender:)), for: .touchUpInside)
        imageAddButton.addTarget(self, action: #selector(addImageButtonTapped(sender:)), for: .touchUpInside)
        
    }
    
    private func setUpTrailingView(){
        titleTrailingView.layer.cornerRadius = 15
        titleTrailingView.layer.borderWidth = 1
        
        contentTrailingView.layer.cornerRadius = 15
        contentTrailingView.layer.borderWidth = 1
        titleTrailingView.layer.borderColor = UIColor.systemGray5.cgColor
        contentTrailingView.layer.borderColor = UIColor.systemGray5.cgColor
        
    }
    
    private func changeTrailViewBorder(){
        UIView.animate(withDuration: 0.5){
            self.titleTrailingView.layer.borderColor = self.titleTextView.text! == "" ? UIColor.systemGray5.cgColor : UIColor.systemGreen.cgColor
            self.contentTrailingView.layer.borderColor = self.contentTextView.text! == "" ? UIColor.systemGray5.cgColor : UIColor.systemGreen.cgColor
        }
    }
    
    @objc func addImageButtonTapped(sender:UIButton){
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        self.present(picker, animated: true)
    }
    
    @objc func borrowButtonTapped(sender:UIButton){
        buttonToggle = true
        setUpButton(state: buttonToggle)
    }
    @objc func lendButtonTapped(sender:UIButton){
        buttonToggle = false
        setUpButton(state: buttonToggle)
    }
    
    @objc func doneButtonTapped(sender:UIButton){
        if doneButtonToggle{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: Date())
            let data = PostData(id: "", title: titleTextView.text, image: "", date: dateString, likeList: [],comments: [], bigCategory: buttonToggle ? "필요해요" : "빌려드려요", smallCategory: "", content: contentTextView.text, nickName: "")
            dataManager.addNewPost(newPost: data)
            navigationController?.popViewController(animated: true)
        } else {
            
            if titleTextView.text! == "" && contentTextView.text! == ""{
                UIView.animate(withDuration: 0.5){
                    self.titleTrailingView.layer.borderColor = UIColor.red.cgColor
                    self.contentTrailingView.layer.borderColor = UIColor.red.cgColor
                }
                self.titleTrailingView.shake()
                self.contentTrailingView.shake()
            } else if titleTextView.text! == ""{
                UIView.animate(withDuration: 0.5){
                    self.titleTrailingView.layer.borderColor = UIColor.red.cgColor
                }
                self.titleTrailingView.shake()
            } else if contentTextView.text! == ""{
                UIView.animate(withDuration: 0.5){
                    self.contentTrailingView.layer.borderColor = UIColor.red.cgColor
                }
                self.contentTrailingView.shake()
            }
            
        }
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
}

extension AddPostViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        
        if titleTextView.text != "" && contentTextView.text != "" {
            doneButtonToggle = true
        } else {
            doneButtonToggle = false
        }
        
        setUpButton(state: buttonToggle)
        changeTrailViewBorder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView == self.titleTextView{
            self.nowTextView = 0
        } else {
            self.nowTextView = 1
        }
    }
}

extension UIView {
    
    func shake() {

        self.transform = CGAffineTransform(translationX: 20, y: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
    }
    
}

extension AddPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true){ () in
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.choiceImage = img
            self.image.image = img
        }
        
    }
    
}
