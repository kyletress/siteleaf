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
          //self.getSitePages("5320f79c5dde22641900013e")
          //let parameters = ["title": "Test UPDATE from iOS App", "visibility": "draft"]
          //self.updatePage("561c8bd069702d54040002da", parameters: parameters)
          //self.getPage("5320f79c5dde22641900013e")
          //self.getAllPages()
          //self.deletePage("561c8bd069702d54040002da")
          //let parameters = ["title": "Test Post from iOS"]
          //self.createPost("5320f82e5dde22b5a6000325", parameters: parameters)
          // CREATE POST MIGHT NOT HAVE WORKED AS EXPECTED. CHECK IT OUT LATER
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
  
  func getSitePages(siteID: String) {
    Alamofire.request(Router.GetSitePages(siteID)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func getAllPages() {
    Alamofire.request(Router.GetAllPages).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func getPage(id: String) {
    Alamofire.request(Router.GetPage(id)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func createPage(siteID: String, pageParams: Dictionary<String, AnyObject>) {
    Alamofire.request(Router.CreatePage(siteID, pageParams)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func updatePage(pageID: String, parameters: Dictionary<String, AnyObject>) {
    Alamofire.request(Router.UpdatePage(pageID, parameters)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func deletePage(pageID: String) {
    Alamofire.request(Router.DeletePage(pageID))
  }
  
  func getPagePosts(pageID: String) {
    Alamofire.request(Router.GetPagePosts(pageID)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func createPost(pageID: String, parameters: Dictionary<String, AnyObject>) {
    Alamofire.request(Router.UpdatePage(pageID, parameters)).responseJSON {
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