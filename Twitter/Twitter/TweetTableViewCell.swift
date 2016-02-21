//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/17/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet : Tweet! {
        didSet {
                        
            let hourDifference = NSCalendar.currentCalendar().components(.Hour, fromDate: tweet!.createdAt!, toDate: NSDate(), options: []).hour
            let minDifference =  NSCalendar.currentCalendar().components(.Minute, fromDate: tweet!.createdAt!, toDate: NSDate(), options: []).minute
            if (hourDifference == 0) {
                timeLabel.text = "\(minDifference)Min"
            } else if (hourDifference <= 24) {
                timeLabel.text = "\(hourDifference)H"
            } else {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                timeLabel.text = dateFormatter.stringFromDate(tweet!.createdAt!)
            }
//            favoriteCountLabel.text = "\(tweet.favouritesCount!)"
//            retweetCountLabel.text = "\(tweet.retweetCount!)"
//            print("Retweet: \(tweet.retweetCount!)")
        }
    }
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.textLabel.text = "description"
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        //like bug when wrapping changes
//        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
//    }

}
