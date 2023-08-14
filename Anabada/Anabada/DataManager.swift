//
//  DataManager.swift
//  Anabada
//
//  Created by SeoJunYoung on 2023/08/14.
//

import Foundation


class DataManager {
    
    static let shared = DataManager()
    
    var postData: [PostData] = [PostData(id: "", title: "", image: "", date: "", comments: [Comment(nickName: "", content: "", date: "")], bigCategory: "", smallCategory: "", content: "", nickName: "")]
    
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

