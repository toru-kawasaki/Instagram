//
//  Comment.swift
//  Instagram
//
//  Created by PC-SYSKAI556 on 2023/03/22.
//

import UIKit
import Firebase
/*
class CommentData: NSObject {
    var id: String
    //var commentDate: Date?
    var commentDate: String?
    var commentUser: String?
    var commentContents: String?
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        let postDic = document.data()
        self.commentDate = postDic["commentDate"] as? String
        self.commentUser = postDic["commentUser"] as? String
        self.commentContents = postDic["commentContents"] as? String
    }
}
*/
struct CommentData: Codable {
    var id: String
    //var commentDate: Date?
    var commentDate: Date?
    var commentUser: String?
    var commentName: String?
    var commentContents: String?
}
