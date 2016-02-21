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
    
    var loginCompletion : ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL!, consumerKey: twitterConsumerKey, consumerSecret: twitterSecretKey)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: ( tweets: [Tweet]?, error: NSError?)-> ()){
        GET("1.1/statuses/home_timeline.json",
            parameters: params,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                //print("user: \(response!)")
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
                
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        /*
        get oauth code
        - requestToken is value returned to be used in verification
        - cptwitterdemo is the url_scheme used in info
        
        1) request token
        2) authorize url
        3) access token
        */

        //fetch request token code & redirect to authorization
        //clean things up before going (sign out)
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            //code when good
            print("Success request token")
            print("\(requestToken.token)")
            //URL used to verify with token "requestToken" that we got back
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            //print(authURL)
            //handle to single application and open to redirect to twitter
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
            //code when bad
            print("Failed request token")
        }
    }
    
    func openUrl(url: NSURL){
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            //code if good
            print("Success access token")
            //saving token
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //using access granted to get jason from API
            TwitterClient.sharedInstance.GET(
                "1.1/account/verify_credentials.json",
                parameters: nil,
                success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                    //print("user: \(response!)")
                    //saving response to dictionary from User
                    let user = User(dictionary: response as! NSDictionary)
                    //assign user
                    User.currentUser = user
                    print("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)

                },
                failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })

            
            }) { (error: NSError!) -> Void in
                //code if bad
                print("Failed acces token")
                self.loginCompletion?(user: nil, error: error)

        }
    }
    
    func createFavorite(id: String) {
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Create a favorite")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error creating a favorite")
            }
        )
    }
    
    func destroyFavorite(id: String) {
        TwitterClient.sharedInstance.POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Destroy a favorite")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error destroying a favorite")
            }
        )
    }
    
    func retweet(id: String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Retweet")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error retweeting")
            }
        )
    }
    
    func unretweet(id: String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Unretweet")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error unretweeting")
            }
        )
    }
    

}
