//
//  DetailViewcontroller.swift
//  Anabada
//
//  Created by 손영하  on 2023/08/18.
//

import UIKit



class DetailViewController: UIViewController {
    
    
    var postData: PostData?
    
    var image1: String?
    
    @IBOutlet weak var ImageView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ImageView.UIImage = image1
//       let image1 = UIImage(named: "catImage1")
    }
    
    
    @IBOutlet weak var BackButton: UINavigationBar!
    
    @IBOutlet weak var UserProfileLabel: UILabel!
    
    @IBOutlet weak var StatusButton: UIButton!
    
    @IBOutlet weak var HeartButton: UIButton!
    
    @IBOutlet weak var CommentLabel: UIButton!
    
   
        


        
    


}
