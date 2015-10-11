//
//  ViewController.swift
//  Siteleaf
//
//  Created by Tress on 7/31/15.
//  Copyright (c) 2015 Kyle Tress. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

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
    let user = emailTextField.text!
    let password = passwordTextField.text!
    let headers = encodeHeaders(user, pass: password)
    
    Alamofire.request(.POST, "https://api.siteleaf.com/v1/auth.json", headers: headers)
      .responseJSON { response in
        if response.result.isSuccess {
          let json = JSON(response.result.value!)
          let key = json["api_key"]
          let secret = json["api_secret"]
          KeychainWrapper.setString("\(key)", forKey: "apiKey")
          KeychainWrapper.setString("\(secret)", forKey: "apiSecret")
          //let retrievedKey = KeychainWrapper.stringForKey("apiKey")
          //let retrievedSecret: String? = KeychainWrapper.stringForKey("apiSecret")
          self.pingServer()
          let defaults = NSUserDefaults.standardUserDefaults()
          defaults.setObject("true", forKey: "userLoggedIn")
        }
    }
  }
  
  func pingServer() {
//    SiteleafAPI.request(Router.Ping)
//    let key = KeychainWrapper.stringForKey("apiKey")!
//    let secret = KeychainWrapper.stringForKey("apiSecret")!
//    let headers = encodeHeaders(key, pass: secret)
//    
//    Alamofire.request(.GET, "https://api.siteleaf.com/v1/ping.json", headers: headers).responseJSON {
//      response in
//      if let JSON = response.result.value {
//        print("JSON: \(JSON)")
//      }
//    }
  }
  
  func encodeHeaders(user: String, pass: String) -> [String: String] {
    let credentialData = "\(user):\(pass)".dataUsingEncoding(NSUTF8StringEncoding)!
    let base64Credentials = credentialData.base64EncodedStringWithOptions([])
    return ["Authorization": "Basic \(base64Credentials)"]
  }

  
}