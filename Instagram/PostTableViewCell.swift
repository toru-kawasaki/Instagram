//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by PC-SYSKAI556 on 2023/03/22.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        // 追加
        self.commentLabel.text = ""
        if postData.comment != nil{
            for comment in postData.comment {
                if let date = comment.commentDate {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let dateString = formatter.string(from: date)
                    self.commentLabel.text! += comment.commentName! + "さん " + dateString + "\n" + comment.commentContents! + "\n"
                }
            }
            /*
            // フォントサイズを設定
            let fontSize: CGFloat = 12.0
            commentLabel.font = UIFont.systemFont(ofSize: fontSize)
            // 表示可能な最大行数を無制限にする
            commentLabel.numberOfLines = 0
            // 文字列が width を超える場合に、単語単位で改行
            commentLabel.lineBreakMode = .byWordWrapping
            // 表示フレームを作成。CGSizeMake(最大幅, 最大高さ)
            let frame = CGSize(width:250, height:250)
            // 文字列の幅に調節したサイズを取得
            let rect = commentLabel.sizeThatFits(frame)
            // UILabel の width の制約に、調節済みの width を設定
            commentHeight.constant = rect.height*/
        }
    }


}
