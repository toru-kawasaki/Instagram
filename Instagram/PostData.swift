//
//  PostData.swift
//  Instagram
//
//  Created by PC-SYSKAI556 on 2023/03/22.
//
import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    //追加
    var comment: [CommentData] = []
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if   postDic["comment"] != nil{
            let mapData = postDic["comment"] as? [Any]
            for data in mapData! {
                //FireStoreの型からSwiftで使用する型に変換する
                let dicData = data as! NSMutableDictionary
                let dic = dicData  as NSDictionary as! [String : AnyObject]
                print("DEBUG_PRINT: data \(dic)")
                //var commentDate: Date?
                let date = dic["commentDate"] as? Timestamp
                let commentDate = date?.dateValue()
                let commentUser = dic["commentUser"] as? String
                let commentName = dic["commentName"] as? String
                let commentContents = dic["commentContents"] as? String
                let commentData = CommentData(id:self.id, commentDate: commentDate, commentUser: commentUser,commentName: commentName, commentContents: commentContents)
                self.comment.append(commentData)
            }
        }
        //let data = mapData
        /*
        if let mapData = postDic["comment"] as? [Any]{
        self.comment = []
        for (_, data) in mapData {
            let dicData = data as! [String:Any]
            print(dicData)
            let id = self.id
            let commentUser = dicData["commentUser"] as! String
            let commentDate = dicData["commentDate"] as! Date
            let commentContents = dicData["commentContents"] as! String
            let comment = CommentData(id:id, commentDate: commentDate,commentUser: commentUser,commentContents:commentContents)
            self.comment.append(comment)
        }
        print(self.comment)
        }*/
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
    }
}
