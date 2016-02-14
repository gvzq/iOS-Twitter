//
//  TwitterClient.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/14/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "IJ248NjFcurccjIhkeRX9jpAA"
let twitterSecretKey = "hHWTuN9jnW8e565Gt9BVY8RgIIY2bjMSroGuzXsDUhQS9N10sq"

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL!, consumerKey: twitterConsumerKey, consumerSecret: twitterSecretKey)
        }
        return Static.instance
    }
    
    
}
