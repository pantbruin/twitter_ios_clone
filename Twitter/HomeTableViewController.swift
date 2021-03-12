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
    
    // Sets up the variable needed for pull to refresh functionality
    let myRefreshControl = UIRefreshControl()

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        // When user logs out, we want to make sure to change the userLoggedIn variable to false so that they cannot access the homescreen if they close the app.
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        // In addition to calling logout() from api, we also want to go back to the login screen. We do that with dismiss
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func loadTweets(){
        
        numberofTweets = 10
        
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberofTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            // We have to clear the tweetArray so that we start fresh from the last api call
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
        self.tableView.reloadData()
        // Once we're done updating the table, we want to stop the refreshing icon at the top of the tablelist
        self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("could not retreive tweets")
        })
    }
    
    func loadMoreTweets(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        // Add an additional 20 tweets to whatever numberOfTweets was before
        numberofTweets = numberofTweets + 10
        let myParams = ["count": numberofTweets]
        
        // The api call below is the exact same api call in loadTweets(), but with endRefreshing removed because we dont need to have that when scrolling down
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            // We have to clear the tweetArray so that we start fresh from the last api call
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
        self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("could not retreive tweets")
        })
        
    }
    
    // This is executed when the user gets to the end of the page. It runs loadMoreTweets
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    
    // Only gets called once, upon initial screen load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Run our API call
//        loadTweets()
        
        // myRefreshControl runs loadTweet again
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    // Always gets called when the view appears again, like navigating back to the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
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
