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
  var siteID: String?
  
    override func viewDidLoad() {
      super.viewDidLoad()
      loadSites()
      sitesTableView.delegate = self
      sitesTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  // TABLE VIEW METHODS
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sites.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You selected cell #\(indexPath.row)!")
    siteID = sites[indexPath.row].id
    print(siteID)
    performSegueWithIdentifier("showPagesSegue", sender: self)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = sitesTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    let site = sites[indexPath.row]
    cell.textLabel!.text = site.title
    cell.detailTextLabel!.text = site.domain
    return cell
  }
  
  func loadSites() {
    SiteleafAPIManager.sharedInstance.getSites { response in
      guard response.result.error == nil else {
        print(response.result.error)
        return
      }
      
      if let fetchedSites = response.result.value {
        self.sites = fetchedSites
      }
      self.sitesTableView.reloadData()
    }
  }
  

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      let vc = segue.destinationViewController as! PagesViewController
      vc.siteID = siteID
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
