//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/16/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            self.tableView.reloadData()
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        return cell
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        refreshControl.endRefreshing()
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
