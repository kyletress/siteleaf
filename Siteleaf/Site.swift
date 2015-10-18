//
//  Site.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/11/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import SwiftyJSON

final class Site: ResponseObjectSerializable, ResponseCollectionSerializable {
  var id: String
  var title: String
  var domain: String
  
//  required init(json: JSON) {
//    self.title = json["title"].string
//    self.id = json["id"].string
//    self.domain = json["domain"].string
//  }
  
  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.title = representation.valueForKeyPath("title") as! String
    self.domain = representation.valueForKeyPath("domain") as! String
    self.id = representation.valueForKeyPath("id") as! String
  }
  
  static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Site] {
    var sites: [Site] = []
    
    if let representation = representation as? [[String: AnyObject]] {
      for userRepresentation in representation {
        if let site = Site(response: response, representation: userRepresentation) {
          sites.append(site)
        }
      }
    }
    
    return sites
  }
  
}
