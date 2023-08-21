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
        
        PostData(id: 0, title: "책", image: UIImage(systemName: "book"), date: "2023-08-20 12:00:00", likeList: ["룬"], comments: [], bigCategory: "필요해요", smallCategory: "", content: "책이 필요해요~", nickName: "은서"),
        PostData(id: 1, title: "연필", image: UIImage(systemName: "pencil"), date: "2023-08-19 12:00:00", likeList: ["룬"], comments: [], bigCategory: "빌려드려요", smallCategory: "", content: "공부를 접습니다..", nickName: "준영"),
        PostData(id: 2, title: "키보드", image: UIImage(systemName: "keyboard"), date: "2023-08-18 12:00:00", likeList: [], comments: [], bigCategory: "필요해요", smallCategory: "", content: "키보드가 필요해요~", nickName: "이랑"),
        PostData(id: 3, title: "안경", image: UIImage(systemName: "eyeglasses"), date: "2023-07-17 12:00:00", likeList: [], comments: [], bigCategory: "필요해요", smallCategory: "", content: "안경이 필요해요~", nickName: "영하")
    ]
    
    var myInfo: UserInfo = UserInfo(nickName: "이랑", profileImage: UIImage(named: "룬"))
    
    var userData: [UserInfo] = [
        UserInfo(nickName: "은서", profileImage: UIImage(systemName: "person.fill")),
        UserInfo(nickName: "준영", profileImage: UIImage(systemName: "person.fill")),
        UserInfo(nickName: "이랑", profileImage: UIImage(systemName: "person")),
        UserInfo(nickName: "영하", profileImage: UIImage(systemName: "person")),
    ]


    func addNewPost(newPost:PostData){
        for i in 0...postData.count - 1{ postData[i].id += 1 }
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
        let changeIndex = postData.filter{$0.nickName == myInfo.nickName}.map{$0.id}

        for i in changeIndex{ postData[i].nickName = newNickName }
        myInfo.nickName = newNickName
        let users = userData.map{$0.nickName}
        guard let choiceIndex = users.firstIndex(of: myInfo.nickName) else { return }
        userData[choiceIndex].nickName = newNickName
    }
    
    func changeProfileImage(_ newImage: UIImage) {
        let changeIndex = postData.filter{$0.nickName == myInfo.nickName}.map{$0.id}

        for i in changeIndex{ userData[i].nickName = myInfo.nickName }
        myInfo.profileImage = newImage
        let users = userData.map{$0.nickName}
        guard let choiceIndex = users.firstIndex(of: myInfo.nickName) else { return }
        userData[choiceIndex].profileImage = newImage
    }

    private init() { }
}

