//
//  Site.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/11/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import SwiftyJSON

class Site {
  var id: String?
  var title: String?
  var domain: String?
  
  required init(json: JSON) {
    self.title = json["title"].string
    self.id = json["id"].string
    self.domain = json["domain"].string
  }
  
  required init () {
  
  }
}
