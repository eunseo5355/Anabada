//
//  Model.swift
//  Anabada
//
//  Created by SeoJunYoung on 2023/08/14.
//

import Foundation

struct PostData {
    var id: String
    var title: String
    var image: String
    var date: String
    var like: Int = 0
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
