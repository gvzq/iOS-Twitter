//
//  User.swift
//  Twitter
//
//  Created by Gerardo Vazquez on 2/15/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "userKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenName :String?
    var profileImageUrl : String?
    var tagLine: String?
    var dictionary: NSDictionary
    
    init(dictionary : NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary ["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        //notify that logout
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                if let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) {
                    do {
                        if let dictionary = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions(rawValue:0)) as? NSDictionary {
                        _currentUser = User(dictionary: dictionary)
                    }
                } catch {
                    print("Error parsing JSON")
                }
            }
        }
            return _currentUser
        }
        
        set(user){
            _currentUser = user
            
            if _currentUser != nil{
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions.PrettyPrinted)
                    //save to nsuderdefaults
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    
                } catch(let error) {
                    print(error)
                    //save to nsuderdefaults
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                    assert(false)
                }
               
            }
            //always flush the disk
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
