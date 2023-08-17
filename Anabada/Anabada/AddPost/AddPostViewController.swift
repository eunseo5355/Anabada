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
    
    @IBOutlet var titleTrailingView: UIView!
    
    @IBOutlet var titleTextView: UITextView!
    
    @IBOutlet var contentTrailingView: UIView!
    
    @IBOutlet var contentTextView: UITextView!
    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    private func setUpUi(){
        titleTextView.delegate = self
        contentTextView.delegate = self
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
}

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
