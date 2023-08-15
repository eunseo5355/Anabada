//
//  PostTableViewCell.swift
//  Anabada
//
//  Created by 배은서 on 2023/08/15.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bigCategoryLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ postData: PostData) {
        titleLabel.text = postData.title
        timeLabel.text = "30분전"
        bigCategoryLabel.text = "빌려줌"
        commentCountLabel.text = "\(postData.comments.count)"
    }
    
}
