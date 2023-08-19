//
//  Model.swift
//  Anabada
//
//  Created by SeoJunYoung on 2023/08/14.
//

import Foundation
import UIKit

struct PostData {
    var id: Int
    var title: String
    var image: UIImage?
    var date: String
    var like: Int = 0
    var likeList: [String]
    var comments: [Comment]
    var bigCategory: String
    var smallCategory: String
    var content: String
    var nickName: String
}

struct Comment {
    var nickName: String
    var content: String
    var date: String
}


struct UserInfo{
    var nickName: String
    var profileImage: UIImage?
}
