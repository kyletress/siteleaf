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
  case GetMe
  case GetUsers
  case GetPages(String)
  case GetPage(String)
  case CreatePage(String, [String: AnyObject])
  case UpdatePage(String, [String: AnyObject])
  case GetAllPages
  
  
  var method: Alamofire.Method {
    switch self {
    case .Ping:
      return .GET
    case .GetSites:
      return .GET
    case GetSite:
      return .GET
    case .GetMe:
      return .GET
    case .GetUsers:
      return .GET
    case .GetPages:
      return .GET
    case .GetPage:
      return .GET
    case .CreatePage:
      return .POST
    case .UpdatePage:
      return .PUT
    case .GetAllPages:
      return .GET
    }
  }
  
  var path: String {
    switch self {
    case .Ping:
      return "/ping.json"
    case .GetSites:
      return "/sites.json"
    case .GetSite (let siteID):
      return "/sites/\(siteID)"
    case .GetMe:
      return "/users/me.json"
    case .GetUsers:
      return "/users.json"
    case .GetPages (let siteID):
      return "/sites/\(siteID)/pages.json"
    case .GetPage (let pageID):
      return "/pages/\(pageID).json"
    case .CreatePage (let siteID, _):
      return "/sites/\(siteID)/pages.json"
    case .UpdatePage (let pageID, _):
      return "/pages/\(pageID).json"
    case .GetAllPages:
      return "/pages.json"
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
    case .CreatePage(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    case .UpdatePage(_, let parameters):
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
    default:
      return mutableURLRequest
    }
  }
}