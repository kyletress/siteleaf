//
//  SitesViewController.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/13/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import UIKit

class SitesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var sitesTableView: UITableView!
  var sites: [String] = ["Kyle Tress", "Morgan Tracey"]
  
    override func viewDidLoad() {
      super.viewDidLoad()
      self.sitesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  // TABLE VIEW METHODS
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sites.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = sitesTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = sites[indexPath.row]
    return cell
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
