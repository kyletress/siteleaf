//
//  Page.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/18/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import SwiftyJSON

final class Page: ResponseObjectSerializable, ResponseCollectionSerializable {
  
  var id: String?
  var title: String
  var body: String
  var visibility: String
  var slug: String?
  var url: String
  var siteID: String
  
  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.title = representation.valueForKeyPath("title") as! String
    self.visibility = representation.valueForKeyPath("visibility") as! String
    self.body = representation.valueForKeyPath("body") as! String
    self.siteID = representation.valueForKeyPath("site_id") as! String
    self.url = representation.valueForKeyPath("url") as! String
  }
  
  static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Page] {
    var pages: [Page] = []
    
    if let representation = representation as? [[String: AnyObject]] {
      for userRepresentation in representation {
        if let page = Page(response: response, representation: userRepresentation) {
          pages.append(page)
        }
      }
    }
    
    return pages
  }
  
  func previewURL() -> String {
    let siteID = self.siteID
    let url = self.url
    return "https://preview-\(siteID).siteleaf.com/\(url)"
  }

}
