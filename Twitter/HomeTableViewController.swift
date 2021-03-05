//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Jesse Pantoja on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // Save the content from our API in a variable
    var tweetArray = [NSDictionary]()
    // Save the # of tweets in a variable
    var numberofTweets: Int!

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        // When user logs out, we want to make sure to change the userLoggedIn variable to false so that they cannot access the homescreen if they close the app.
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        // In addition to calling logout() from api, we also want to go back to the login screen. We do that with dismiss
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadTweet(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 10]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
        self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("could not retreive tweets")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Run our API call
        loadTweet()
        

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tweetArray.count
    }


}
