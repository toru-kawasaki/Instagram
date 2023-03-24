//
//  CommentViewController.swift
//  Instagram
//
//  Created by PC-SYSKAI556 on 2023/03/22.
//

import UIKit
import Firebase

class CommentViewController: UIViewController {

    var imageId :String = ""
    @IBOutlet weak var commentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func commentButton(_ sender: Any) {
        // FireStoreに投稿データを保存する
        // コメントデータの保存場所を定義する
        //let postRef = Firestore.firestore().collection(Const.CommentPath).document()
        let postRef = Firestore.firestore().collection(Const.PostPath).document(imageId)
        //postRef.setValuesForKeys(imageId)
        // likesを更新する
        if let myid = Auth.auth().currentUser?.uid {
            // 更新データを作成する
            var updateValue: FieldValue
            /*let timestamp = FieldValue.serverTimestamp() as! Timestamp
            let date = timestamp.dateValue()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateString = formatter.string(from: date)
            */
            let name = Auth.auth().currentUser?.displayName
            let postDic = [
                //"commentDate": FieldValue.serverTimestamp(),
                "commentDate": Date(),
                "commentUser": myid,
                "commentName": name!,
                "commentContents": self.commentText.text!,
                ] as [String : Any]
            print("DEBUG_PRINT: コメント作成")
            // likesに更新データを書き込む
            updateValue = FieldValue.arrayUnion([postDic])
            //let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comment": updateValue])
        }
        /*
        let myid = Auth.auth().currentUser?.uid
        let postDic = [
            "imageId" : imageId,
            "commentDate": FieldValue.serverTimestamp(),
            "commentUser": myid,
            "commentContents": self.commentText.text!,
            ] as [String : Any]
        postRef.setData(postDic)*/
        // コメント処理が完了したので先頭画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
