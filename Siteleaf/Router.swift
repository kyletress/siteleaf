//
//  Router.swift
//  
//
//  Created by Kyle Tress on 10/11/15.
//
//

import Alamofire
import SwiftKeychainWrapper

enum Router: URLRequestConvertible {
  static let baseURLString = "https://api.siteleaf.com/v1"
  
  case Ping
  case GetSites
  case GetSite(String)
  case CreateSite([String: AnyObject])
  case UpdateSite(String, [String: AnyObject])
  case DeleteSite(String)
  case GetMe
  case GetUsers
  case GetSiteUsers(String)
  case GetSitePages(String)
  case GetPage(String)
  case CreatePage(String, [String: AnyObject])
  case UpdatePage(String, [String: AnyObject])
  case GetAllPages
  case DeletePage(String)
  case GetSitePosts(String)
  case GetPagePosts(String)
  case CreatePagePost(String, [String: AnyObject])
  case GetSiteAssets(String)
  case GetAllPosts
  case GetPost(String)
  case UpdatePost(String, [String: AnyObject])
  case DeletePost(String)
  // TODO: Taxonomies, Assets, (site theme files?) 
  
  
  var method: Alamofire.Method {
    switch self {
    case .Ping:
      return .GET
    case .GetSites:
      return .GET
    case .GetSite:
      return .GET
    case .CreateSite:
      return .POST
    case .UpdateSite:
      return .PUT
    case .DeleteSite:
      return .DELETE
    case .GetMe:
      return .GET
    case .GetUsers:
      return .GET
    case .GetSiteUsers:
      return .GET
    case .GetSitePages:
      return .GET
    case .GetPage:
      return .GET
    case .CreatePage:
      return .POST
    case .UpdatePage:
      return .PUT
    case .GetAllPages:
      return .GET
    case .DeletePage:
      return .DELETE
    case .GetSitePosts:
      return .GET
    case .GetPagePosts:
      return .GET
    case .CreatePagePost:
      return .POST
    case .GetSiteAssets:
      return .GET
    case .GetAllPosts:
      return .GET
    case .GetPost:
      return .GET
    case .UpdatePost:
      return .PUT
    case .DeletePost:
      return .DELETE
    }
  }
  
  var path: String {
    switch self {
    case .Ping:
      return "/ping.json"
    // SITES
    case .GetSites:
      return "/sites.json"
    case .GetSite (let siteID):
      return "/sites/\(siteID)"
    case .CreateSite(_):
      return "/sites.json"
    case .UpdateSite(let siteID, _):
      return "/sites/\(siteID).json"
    case .DeleteSite(let siteID):
      return "/sites/\(siteID).json"
    // USERS
    case .GetMe:
      return "/users/me.json"
    case .GetUsers:
      return "/users.json"
    case .GetSiteUsers(let siteID):
      return "/sites/\(siteID)/users.json"
    // PAGES
    case .GetSitePages (let siteID):
      return "/sites/\(siteID)/pages.json"
    case .GetPage (let pageID):
      return "/pages/\(pageID).json"
    case .CreatePage (let siteID, _):
      return "/sites/\(siteID)/pages.json"
    case .UpdatePage (let pageID, _):
      return "/pages/\(pageID).json"
    case .GetAllPages:
      return "/pages.json"
    case .DeletePage (let pageID):
      return "/pages/\(pageID).json"
    // POSTS
    case .GetSitePosts(let siteID):
      return "/sites/\(siteID)/posts.json"
    case .GetPagePosts(let pageID):
      return "/pages/\(pageID)/posts.json"
    case .CreatePagePost(let pageID, _):
      return "/pages/\(pageID)/posts.json"
    case .GetAllPosts:
      return "/posts.json"
    case .GetPost(let postID):
      return "/posts/\(postID).json"
    case .UpdatePost(let postID, _):
      return "posts/\(postID).json"
    case .DeletePost(let postID):
      return "posts/\(postID).json"
    // ASSETS
    case .GetSiteAssets(let siteID):
      return "/sites/\(siteID)/assets.json"
    }
  }
  
  // MARK: URLRequestConvertible
  
  var URLRequest: NSMutableURLRequest {
    let URL = NSURL(string: Router.baseURLString)!
    let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
    mutableURLRequest.HTTPMethod = method.rawValue
    // set up headers
    let retrievedKey = KeychainWrapper.stringForKey("apiKey")!
    let retrievedSecret = KeychainWrapper.stringForKey("apiSecret")!
    let credentialData = "\(retrievedKey):\(retrievedSecret)".dataUsingEncoding(NSUTF8StringEncoding)!
    let base64Credentials = credentialData.base64EncodedStringWithOptions([])

    mutableURLRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
    switch self {
    case .CreateSite(let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    case .UpdateSite(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    case .CreatePage(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    case .UpdatePage(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    case .CreatePagePost(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    case .UpdatePost(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    default:
      return mutableURLRequest
    }
  }
}