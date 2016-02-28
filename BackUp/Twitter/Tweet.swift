//
//  Tweet.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/14/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var timeStamp: NSDate?
    var favouritesCount: Int?
    var retweetCount: Int?
    var favorited: Bool?
    var retweeted: Bool?
    var id: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        favouritesCount = dictionary["favourites_count"] as? Int
        if (favouritesCount == nil) {
            favouritesCount = 0
        }
        retweetCount = dictionary["retweet_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
        id = dictionary["id_str"] as? String
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
