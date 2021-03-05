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
    
    // onLoginButton is an ACTION not an outlet (an outlet means that you are creating something that you will change) but an action means
    @IBAction func onLoginButton(_ sender: Any) {
        
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        // url: the url we want to call
        // success: the actions to perform upon success
        // failure: the actions to perform upon failure
        TwitterAPICaller.client?.login(url: myUrl, success: {
            // When login is successful, we want the user to go from login to home screen with "loginToHome" identifier
            self.performSegue(withIdentifier: "loginToHome", sender: self)
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
