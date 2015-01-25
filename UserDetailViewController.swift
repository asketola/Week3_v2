//
//  UserDetailViewController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/21/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  
  var selectedUser : User!
  
  // Sets up the UIlabels
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // populates the images and texts 
      self.imageView.image = selectedUser.avatarImage
      self.userNameLabel.text = selectedUser.name
      self.navigationController?.delegate = nil // <- to kill the zombie view controller - the back button seems to work with and without this code
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
