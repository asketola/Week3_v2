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
      
      
      // couldn't get this part to work.
//        NetworkController.sharedNetworkController.fetchMyProfile(callback: {myProfiles, errorDescription) -> (Void) in
//         return self.myProfile = myProfiles!
//          self.nameLabel.text = self.myProfile.name
//          self.userNameLabel.text = self.myProfile.userName
//          self.companyLabel.text = self.myProfile.company
//          self.cityLabel.text = self.myProfile.city
//          self.joinedDateLabel.text = self.myProfile.joinedDate
//          })
//
//      NetworkController.sharedNetworkController.fetchProfileImageForURL(myProfile.avatarURL, completionHandler: { (image) -> (Void) in
//        self.myProfile.avatarImage = image
//        self.userImage.image = self.myProfile.avatarImage
//      })
      
      // needs more work to get these labels. . . . . . .
      // self.followersLabel.text = myProfile.followersNumber
      // self.starredLabel.text = myProfile.starredNumber
      // self.followingLabel.text = myProfile.followersNumber
      
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
