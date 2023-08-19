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
    
    lazy var postData: [PostData] = [
        PostData(id: "", title: "책", image: UIImage(systemName: "folder"), date: "", likeList: ["룬"], comments: [], bigCategory: "필요해요", smallCategory: "", content: "", nickName: "은서"),
        PostData(id: "", title: "연필", image: UIImage(systemName: "folder"), date: "", likeList: ["룬"], comments: [], bigCategory: "빌려드려요", smallCategory: "", content: "", nickName: "준영"),
        PostData(id: "", title: "거울", image: UIImage(systemName: "folder"), date: "", likeList: [], comments: [], bigCategory: "필요해요", smallCategory: "", content: "", nickName: "룬"),
        PostData(id: "", title: "안경", image: UIImage(systemName: "folder"), date: "", likeList: [], comments: [], bigCategory: "필요해요", smallCategory: "", content: "", nickName: "영하")
    ]
    
    var myInfo: UserInfo = UserInfo(nickName: "룬", profileImage: UIImage(named: "룬"))
    
    var userData: [UserInfo] = [
        UserInfo(nickName: "은서", profileImage: UIImage(systemName: "person.fill")),
        UserInfo(nickName: "준영", profileImage: UIImage(systemName: "folder")),
        UserInfo(nickName: "이랑", profileImage: UIImage(systemName: "person")),
        UserInfo(nickName: "영하", profileImage: UIImage(systemName: "person")),
    ]


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
    
    func changeNickName(_ newNickName: String) {
        myInfo.nickName = newNickName
        let users = userData.map{$0.nickName}
        guard let choiceIndex = users.firstIndex(of: myInfo.nickName) else { return }
        userData[choiceIndex].nickName = newNickName
    }

    private init() { }
}

