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
    
    private func calculateTimeAgo(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        let currentTime = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .day, .month], from: date, to: currentTime)
        
        if let months = components.month, months > 0 {
            return "\(months)달 전"
        } else if let days = components.day, days > 0 {
            return "\(days)일 전"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)시간 전"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)분 전"
        } else {
            return "방금 전"
        }
    }
    
    
    func bind(_ postData: PostData) {
        titleLabel.text = postData.title
        timeLabel.text = calculateTimeAgo(from: postData.date)
        bigCategoryLabel.text = postData.bigCategory
        commentCountLabel.text = "\(postData.comments.count)"
    }
    
}
