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
  var sites = [Site]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      loadSites()
      sitesTableView.delegate = self
      sitesTableView.dataSource = self
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
    let cell = sitesTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    let site = sites[indexPath.row]
    cell.textLabel!.text = site.title
    cell.detailTextLabel!.text = site.domain
    return cell
  }
  
  func loadSites() {
    //SiteleafAPIManager.sharedInstance.getSites()
    let site1 = Site()
    site1.title = "Kyle Tress"
    site1.domain = "kyletress.com"
    let site2 = Site()
    site2.title = "Morgan Tracey"
    site2.domain = "morgantracey.us"
    self.sites = [site1, site2]
    sitesTableView.reloadData()
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
