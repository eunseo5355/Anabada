//
//  DataManager.swift
//  Anabada
//
//  Created by SeoJunYoung on 2023/08/14.
//

import Foundation
import UIKit


class DataManager {
    
    static let shared = DataManager()
    
    var postData: [PostData] = [
        PostData(id: "", title: "책", image: UIImage(systemName: "folder"), date: "", likeList: ["룬"], comments: [], bigCategory: "필요해요", smallCategory: "", content: "", nickName: "은서"),
        PostData(id: "", title: "연필", image: UIImage(systemName: "folder"), date: "", likeList: ["룬"], comments: [], bigCategory: "빌려드려요", smallCategory: "", content: "", nickName: "준영"),
        PostData(id: "", title: "거울", image: UIImage(systemName: "folder"), date: "", likeList: [], comments: [], bigCategory: "필요해요", smallCategory: "", content: "", nickName: "룬"),
        PostData(id: "", title: "안경", image: UIImage(systemName: "folder"), date: "", likeList: [], comments: [], bigCategory: "필요해요", smallCategory: "", content: "", nickName: "영하")
    ]
    
    var myNickName: String = "룬"
    var myProfileImage = UIImage(named: "룬")
    
    func addNewPost(newPost:PostData){
        postData.insert(newPost, at: 0)
    }
    
    func addNewComment(postIndex: Int, newComment: Comment){
        postData[postIndex].comments.insert(newComment, at: 0)
    }
    
    func removePost(postIndex: Int){
        postData.remove(at: postIndex)
    }
    
    func removeComment(postIndex: Int, commentIndex: Int){
        postData[postIndex].comments.remove(at: commentIndex)
    }

    private init() { }
}

