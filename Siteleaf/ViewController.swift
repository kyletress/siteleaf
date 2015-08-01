//
//  ViewController.swift
//  Siteleaf
//
//  Created by Tress on 7/31/15.
//  Copyright (c) 2015 Kyle Tress. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  @IBAction func loginButton() {
      // setup credentials
    let loginString = "\(emailTextField.text):\(passwordTextField.text)"
    let loginData = loginString.dataUsingEncoding(NSUTF8StringEncoding)
    let base64Credentials = loginData!.base64EncodedStringWithOptions(nil)
    let headers = ["Authorization": "Basic \(base64Credentials)"]
      
      // create the request and retrieve keys
    Alamofire.request(.POST, "https://api.siteleaf.com/v1/auth.json", headers: headers)
      .responseJSON { _, _, JSON, _ in
        println(JSON)
    }
  }
}