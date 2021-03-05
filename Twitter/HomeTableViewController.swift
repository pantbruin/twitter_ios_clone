//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Jesse Pantoja on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        // When user logs out, we want to make sure to change the userLoggedIn variable to false so that they cannot access the homescreen if they close the app.
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        // In addition to calling logout() from api, we also want to go back to the login screen. We do that with dismiss
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
