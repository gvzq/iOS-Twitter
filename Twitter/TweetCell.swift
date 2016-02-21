//
//  TweetCell.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/17/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBAction func onFavorite(sender: AnyObject) {
        if (tweet.favorited!) {
            TwitterClient.sharedInstance.destroyFavorite(tweet.id!)
            tweet.favouritesCount!--
            tweet.favorited = false
        } else {
            TwitterClient.sharedInstance.createFavorite(tweet.id!)
            tweet.favouritesCount!++
            tweet.favorited = true
        }
        favoriteCountLabel.text = "\(tweet.favouritesCount!)"
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if (tweet.retweeted!) {
            TwitterClient.sharedInstance.unretweet(tweet.id!)
            tweet.retweetCount!--
            tweet.retweeted = false
        } else {
            TwitterClient.sharedInstance.retweet(tweet.id!)
            tweet.retweetCount!++
            tweet.retweeted = true
            print("\(tweet.id!)")
        }
        retweetCountLabel.text = "\(tweet.retweetCount!)"
    }
    
    
    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            nameLabel.text = tweet.user?.name
            tweetTextLabel.text = tweet.text
            timeStampLabel.text = tweet.createdAtString
            let hourDifference = NSCalendar.currentCalendar().components(.Hour, fromDate: tweet.createdAt!, toDate: NSDate(), options: []).hour
            let minDifference =  NSCalendar.currentCalendar().components(.Minute, fromDate: tweet.createdAt!, toDate: NSDate(), options: []).minute
            if (hourDifference == 0) {
                timeStampLabel.text = "\(minDifference)Min"
            } else if (hourDifference <= 24) {
                timeStampLabel.text = "\(hourDifference)H"
            } else {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                timeStampLabel.text = dateFormatter.stringFromDate(tweet.createdAt!)
            }
            favoriteCountLabel.text = "\(tweet.favouritesCount!)"
            retweetCountLabel.text = "\(tweet.retweetCount!)"
            print("Retweet: \(tweet.retweetCount!)")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
