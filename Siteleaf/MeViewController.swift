//
//  MeViewController.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/13/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MeViewController: UIViewController {

  @IBOutlet weak var userNameLabel: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
    setNameLabel()
    SiteleafAPIManager.sharedInstance.pingServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  
  @IBAction func logOutButton(sender: AnyObject) {
    
  }
  
  func getMe() {
    Alamofire.request(Router.GetMe).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
    }
  }
  
  func setNameLabel() {
    Alamofire.request(Router.GetMe).responseJSON {
      response in
      let json = JSON(response.result.value!)
      print(json)
      self.userNameLabel.text = json["fullname"].string
    }
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
