//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/16/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    @IBOutlet weak var tweetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
        
        //when using >= in constrains (auto layout)
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        //fix scroll bar for ball parking
        tweetTableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
        }
        
        loadProfile()
    }

    func loadProfile(){
        TwitterClient.sharedInstance
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets!.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        
        //tweetTextLabel.text = tweet!.text
       /// cell.profileImageView.setImageWithURL(NSURL(string: (tweet!.user?.profileImageUrl)!)!)
        //userNameLabel.text = tweet!.user?.name
        cell.userNameLabel.text = "GERARDO"
        
        //timeLabel.text = tweet!.createdAtString
       cell.timeLabel.text = "TODAY"

        
        cell.tweet = tweets![indexPath.row]
        return cell
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
