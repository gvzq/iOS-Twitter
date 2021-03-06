//
//  UserTweetCell.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/24/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBAction func onFavorite(sender: AnyObject) {
        if (tweet.favorited!) {
            TwitterClient.sharedInstance.destroyFavorite(tweet.id!)
            tweet.favouritesCount!--
            tweet.favorited = false
            favoriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
            favoriteCountLabel.textColor = UIColor.grayColor()
        } else {
            TwitterClient.sharedInstance.createFavorite(tweet.id!)
            tweet.favouritesCount!++
            tweet.favorited = true
            favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
            favoriteCountLabel.textColor = UIColor.redColor()
        }
        favoriteCountLabel.text = "\(tweet.favouritesCount!)"
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if (tweet.retweeted!) {
            TwitterClient.sharedInstance.unretweet(tweet.id!)
            tweet.retweetCount!--
            tweet.retweeted = false
            retweetButton.setImage(UIImage(named: "retweet"), forState: .Normal)
            retweetCountLabel.textColor = UIColor.grayColor()
        } else {
            TwitterClient.sharedInstance.retweet(tweet.id!)
            tweet.retweetCount!++
            tweet.retweeted = true
            retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
            retweetCountLabel.textColor = UIColor(red:0.1, green:0.72, blue:0.6, alpha:1.0)
        }
        retweetCountLabel.text = "\(tweet.retweetCount!)"
    }
    
    var tweet: Tweet! {
        didSet {
            userProfileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            userNameLabel.text = tweet.user?.name
            tweetTextLabel.text = tweet.text
            timeLabel.text = tweet.createdAtString
            let hourDifference = NSCalendar.currentCalendar().components(.Hour, fromDate: tweet.createdAt!, toDate: NSDate(), options: []).hour
            let minDifference =  NSCalendar.currentCalendar().components(.Minute, fromDate: tweet.createdAt!, toDate: NSDate(), options: []).minute
            if (hourDifference == 0) {
                timeLabel.text = "\(minDifference)m"
            } else if (hourDifference <= 24) {
                timeLabel.text = "\(hourDifference)h"
            } else {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                timeLabel.text = dateFormatter.stringFromDate(tweet.createdAt!)
            }
            favoriteCountLabel.text = "\(tweet.favouritesCount!)"
            retweetCountLabel.text = "\(tweet.retweetCount!)"
            if (tweet.favorited!) {
                favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
                favoriteCountLabel.textColor = UIColor.redColor()
            } else {
                favoriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
                favoriteCountLabel.textColor = UIColor.grayColor()
            }
            if (tweet.retweeted!) {
                retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
                retweetCountLabel.textColor = UIColor(red:0.1, green:0.72, blue:0.6, alpha:1.0)
            } else {
                retweetButton.setImage(UIImage(named: "retweet"), forState: .Normal)
                retweetCountLabel.textColor = UIColor.grayColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
