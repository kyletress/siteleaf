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
    let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
    let base64Credentials = credentialData.base64EncodedStringWithOptions([])
    let headers = ["Authorization": "Basic \(base64Credentials)"]
    
    Alamofire.request(.POST, "https://api.siteleaf.com/v1/auth.json", headers: headers)
      .responseJSON { response in
        if response.result.isSuccess {
          let json = JSON(response.result.value!)
          print(json)
          let key = json["api_key"].stringValue
          let secret = json["api_secret"].stringValue
          
          KeychainWrapper.setString("\(key)", forKey: "apiKey")
          KeychainWrapper.setString("\(secret)", forKey: "apiSecret")
          //self.pingServer()
          //self.getMe()
          //self.getSites()
          //self.getSite("5320f79c5dde22641900013e")
          self.getPages("5320f79c5dde22641900013e")
          let defaults = NSUserDefaults.standardUserDefaults()
          defaults.setObject("true", forKey: "userLoggedIn")
        }
    }
  }
  
  func pingServer() {
    Alamofire.request(Router.Ping).responseJSON {
      response in
        let json = JSON(response.result.value!)
        print(json)
    }
  }
  
  func getMe() {
    Alamofire.request(Router.GetMe).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func getSites() {
    Alamofire.request(Router.GetSites).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func getSite(siteID: String) {
    Alamofire.request(Router.GetSite(siteID)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      //print(json)
      if let domain = json["domain"].string {
        print(domain)
      }
    }
  }
  
  func getPages(siteID: String) {
    Alamofire.request(Router.GetPages(siteID)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func encodeHeaders(user: String, pass: String) -> [String: String] {
    let credentialData = "\(user):\(pass)".dataUsingEncoding(NSUTF8StringEncoding)!
    let base64Credentials = credentialData.base64EncodedStringWithOptions([])
    return ["Authorization": "Basic \(base64Credentials)"]
  }

  
}