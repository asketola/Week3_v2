//
//  WebViewController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/22/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  let webView = WKWebView()
  var url : String!

    override func viewDidLoad() {
        super.viewDidLoad()
      self.webView.frame = self.view.frame // <- defines the webView's size
      self.view.addSubview(self.webView)  // <- adds it to the subView
      
      let request = NSURLRequest(URL: NSURL(string: self.url)!)  // <- sends the request for the website
      self.webView.loadRequest(request)  // loads the website into the webView

      self.navigationController?.delegate = nil // <- to kill the zombie view controller

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
