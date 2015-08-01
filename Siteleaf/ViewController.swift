//
//  ViewController.swift
//  Siteleaf
//
//  Created by Tress on 7/31/15.
//  Copyright (c) 2015 Kyle Tress. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func loginButton() {
      // setup credentials
    let loginString = "\(emailTextField.text):\(passwordTextField.text)"
    let loginData = loginString.dataUsingEncoding(NSUTF8StringEncoding)
    let base64Credentials = loginData!.base64EncodedStringWithOptions(nil)
    let headers = ["Authorization": "Basic \(base64Credentials)"]
      
      // create the request and retrieve keys
    Alamofire.request(.POST, "https://api.siteleaf.com/v1/auth.json", headers: headers)
      .responseJSON { request, response, data, error in
        var json = JSON(data!)
        let key = json["api_key"]
        let secret = json["api_secret"]
        KeychainWrapper.setString("\(key)", forKey: "apiKey")
        KeychainWrapper.setString("\(secret)", forKey: "apiSecret")
        let retrievedKey: String? = KeychainWrapper.stringForKey("apiKey")
        let retrievedSecret: String? = KeychainWrapper.stringForKey("apiSecret")
    }

    Alamofire.request(.GET, "https://api.siteleaf.com/v1/ping.json", headers: headers)
      .responseJSON { request, response, data, error in
        var json = JSON(data!)
        println(json)
    }
    
  }
}