//
//  PagesViewController.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/15/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import UIKit

class PagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var pages = [Page]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadPages()
    tableView.delegate = self
    tableView.dataSource = self

  }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
  
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
    }
  
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
    }
  
  // TABLE VIEW METHODS
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pages.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    let page = pages[indexPath.row]
    cell.textLabel!.text = page.title
    cell.detailTextLabel!.text = page.visibility
    if page.visibility == "draft" {
      cell.detailTextLabel!.textColor = UIColor.redColor()
    } else {
      cell.detailTextLabel!.textColor = UIColor.grayColor()
    }
    return cell
  }
  
  func loadPages() {
    SiteleafAPIManager.sharedInstance.getSitePages("5320f79c5dde22641900013e") { response in
      guard response.result.error == nil else {
        print(response.result.error)
        return
      }
      
      if let fetchedPages = response.result.value {
        self.pages = fetchedPages
      }
      self.tableView.reloadData()
    }
  }
    


}
