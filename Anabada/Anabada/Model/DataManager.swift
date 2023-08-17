//
//  DataManager.swift
//  Anabada
//
//  Created by SeoJunYoung on 2023/08/14.
//

import Foundation


class DataManager {
    
    static let shared = DataManager()
    
    var postData: [PostData] = [PostData(id: "", title: "라켓", image: "", date: "", likeList: ["룬", "랑"], comments: [Comment(nickName: "", content: "", date: "")], bigCategory: "", smallCategory: "", content: "", nickName: "은서"),
                                PostData(id: "", title: "게임칩", image: "", date: "", likeList: ["은서"], comments: [Comment(nickName: "", content: "", date: "")], bigCategory: "", smallCategory: "", content: "", nickName: "랑"),
                                PostData(id: "", title: "안마기", image: "", date: "", likeList: [""], comments: [Comment(nickName: "", content: "", date: "")], bigCategory: "", smallCategory: "", content: "", nickName: "룬"),
                                PostData(id: "", title: "무선키보드", image: "", date: "", likeList: [""], comments: [Comment(nickName: "", content: "", date: "")], bigCategory: "", smallCategory: "", content: "", nickName: "룬"),
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
    

    private init() { }
}

