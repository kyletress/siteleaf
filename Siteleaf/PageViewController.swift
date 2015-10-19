//
//  PageViewController.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/18/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import UIKit
import SafariServices

class PageViewController: UIViewController {
  
  @IBOutlet weak var bodyTextView: UITextView!
  
  var page: Page?
  
    override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.title = page!.title
      bodyTextView.text = page!.body
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
  @IBAction func previewPageButton(sender: AnyObject) {
    if let url = NSURL(string: "https://preview-\(page!.siteID).siteleaf.com/\(page!.url)") {
      let vc = SFSafariViewController(URL: url, entersReaderIfAvailable: false)
      presentViewController(vc, animated: true, completion: nil)
    }
  }

}
