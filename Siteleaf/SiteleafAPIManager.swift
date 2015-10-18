//
//  SiteleafAPIManager.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/13/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SiteleafAPIManager {
  static let sharedInstance = SiteleafAPIManager()
  
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
  
  func getSites(completionHandler: (Response<[Site], NSError>) -> Void) {
    Alamofire.request(Router.GetSites)
      .validate()
      .responseCollection { (response: Response<[Site], NSError>) in
        //debugPrint(response)
        completionHandler(response)
        print(response)
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
  
  func getSitePages(siteID: String, completionHandler: (Response<[Page], NSError>) -> Void) {
    Alamofire.request(Router.GetSitePages(siteID))
      .validate()
      .responseCollection { (response: Response<[Page], NSError>) in
        completionHandler(response)
        print(response)
//      response in
//      let json = JSON(response.result.value!)
//      print(json)
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
  
  func createPagePost(pageID: String, parameters: Dictionary<String, AnyObject>) {
    Alamofire.request(Router.CreatePagePost(pageID, parameters)).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func deletePost(postID: String) {
    Alamofire.request(Router.DeletePost(postID))
  }
  
}