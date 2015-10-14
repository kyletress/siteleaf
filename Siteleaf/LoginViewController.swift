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

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
          let key = json["api_key"].stringValue
          let secret = json["api_secret"].stringValue
          
          KeychainWrapper.setString("\(key)", forKey: "apiKey")
          KeychainWrapper.setString("\(secret)", forKey: "apiSecret")
          SiteleafAPIManager.sharedInstance.pingServer()
          //self.getMe()
          //self.getSites()
          //self.getSite("5320f79c5dde22641900013e")
          //self.getSitePages("5320f79c5dde22641900013e")
          //let parameters = ["title": "Test UPDATE from iOS App", "visibility": "draft"]
          //self.updatePage("561c8bd069702d54040002da", parameters: parameters)
          //self.getPage("5320f79c5dde22641900013e")
          //self.getAllPages()
          //self.deletePage("561c8bd069702d54040002da")
          //let parameters = ["title": "Test FAQs from iOS"]
          //self.createPagePost("53e6aa6b5dde227e04000213", parameters: parameters)
          //self.getPagePosts("53e6aa6b5dde227e04000213")
          //self.deletePost("561d591669702d53e4000345")
          let defaults = NSUserDefaults.standardUserDefaults()
          defaults.setObject("true", forKey: "userLoggedIn")
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
          let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
          appDelegate.window?.rootViewController = tabBarController
        }
    }
  }
    
  func encodeHeaders(user: String, pass: String) -> [String: String] {
    let credentialData = "\(user):\(pass)".dataUsingEncoding(NSUTF8StringEncoding)!
    let base64Credentials = credentialData.base64EncodedStringWithOptions([])
    return ["Authorization": "Basic \(base64Credentials)"]
  }

  
}