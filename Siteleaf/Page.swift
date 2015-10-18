//
//  Page.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/18/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import SwiftyJSON

final class Page: ResponseObjectSerializable, ResponseCollectionSerializable {
  
  var title: String
  var visibility: String
  
  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.title = representation.valueForKeyPath("title") as! String
    self.visibility = representation.valueForKeyPath("visibility") as! String
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

}
