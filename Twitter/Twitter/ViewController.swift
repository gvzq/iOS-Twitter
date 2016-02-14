//
//  ViewController.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/14/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func onLogin(sender: AnyObject) {
        //clean things up before going (sign out)
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        /*
        get oauth code
            - requestToken is value returned to be used in verification
            - cptwitterdemo is the url_scheme used in info
        
        1) request token
        2) authorize url
        3) access token
        */
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            //code when good
            //print("Success request token")
            //print("\(requestToken.token)")
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
    
   }

