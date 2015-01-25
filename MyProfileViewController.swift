//
//  MyProfileViewController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/24/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
  
  var myProfile : Profile!
  
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var joinedDateLabel: UILabel!
  @IBOutlet weak var followersLabel: UILabel!
  @IBOutlet weak var starredLabel: UILabel!
  @IBOutlet weak var followingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
//      NetworkController.sharedNetworkController.fetchMyProfile(username: String()) { ([Profile]?, String) -> (Void) in
//        self.myProfile = [Profile]()
//      }
//
//      NetworkController.sharedNetworkController.fetchProfileImageForURL(myProfile.avatarURL, completionHandler: { (image) -> (Void) in
//        self.myProfile.avatarImage = image
//      })
      
//      NetworkController.sharedNetworkController.fetchAvatarImageForURL(user.avatarURL, completionHandler: { (image) -> (Void) in
//        cell.imageView.image = image
//        user.avatarImage  = image
      
//      self.userImage.image = myProfile.avatarImage
//      self.nameLabel.text = myProfile.name
//      self.userNameLabel.text = myProfile.userName
//      self.companyLabel.text = myProfile.company
//      self.cityLabel.text = myProfile.city
//      self.joinedDateLabel.text = myProfile.joinedDate
//      self.followersLabel.text = myProfile.followersNumber
//      self.starredLabel.text = myProfile.starredNumber
//      self.followingLabel.text = myProfile.followersNumber
      
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
