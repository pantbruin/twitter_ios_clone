//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jesse Pantoja on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // This runs when the page (LoginViewController) shows up
    override func viewDidAppear(_ animated: Bool) {
        
        // If userLoggedIn from UserDefaults is true, then we know that the user has previously logged in
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            // Thus segue to the loginToHome 
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
        
        
    }
    
    
    // onLoginButton is an ACTION not an outlet (an outlet means that you are creating something that you will change) but an action means
    @IBAction func onLoginButton(_ sender: Any) {
        
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        // url: the url we want to call
        // success: the actions to perform upon success
    
        TwitterAPICaller.client?.login(url: myUrl, success: {
            
            // Save a login session for a user
            // first arg is a value we want to set. We used a bool because login state has only two states. second arg is the name of they key that we want to save first arg value in
            // Anytime someone logs it it creates a variable userLoggedIn, sets it to true so that next time user logs in, app looks at this variable to see if the user is logged in
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            // When login is successful, we want the user to go from login to home screen with "loginToHome" identifier
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            
            // failure: the actions to perform upon failure
        }, failure: { (Error) in
            print("Could not login!")
        })
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
