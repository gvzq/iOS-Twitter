//
//  ViewController.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/14/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class ViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = "https://pbs.twimg.com/profile_images/666407537084796928/YBGgi9BO.png"
        let logoUrl = NSURL(string: url)
        self.logo.setImageWithURL(logoUrl!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user:User?, error:NSError?) in
            if user != nil {
                //perfom segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            else{
                //handle login error
            }
        }
        

        
    }
    
   }

