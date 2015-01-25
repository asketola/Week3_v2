//
//  SearchUsersViewController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/21/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {


  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.collectionView.dataSource = self
      self.searchBar.delegate = self
       self.navigationController?.delegate = self
      

        // Do any additional setup after loading the view.
    }
  
  // Collection View requirement, how many to make
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
  }
  
  // Collection View requirement, how to draw and fill the cell
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
    cell.imageView.image = nil   // <- makes all the images blank to begin with
    var user = self.users[indexPath.row]  // <- seperates the user element from the users array
    if user.avatarImage == nil {  // <- when there is no image, it uses the networkController singlet to call the fetch function, uses the user.avatarURL as input, returns an image
      NetworkController.sharedNetworkController.fetchAvatarImageForURL(user.avatarURL, completionHandler: { (image) -> (Void) in
        cell.imageView.image = image  // <- put the image in the cell
        user.avatarImage  = image   // <- links the image to the name
        self.users[indexPath.row] = user  // <-????
      })
    } else {
      cell.imageView.image = user.avatarImage
    }
    return cell
  }
  
  // when the button is clicked, it uses the NetworkController singlton to find the users with the name input
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()  // <- keyboard goes down when you press return
    
    // uses the searchBar as the input, gives back the users and an erroe description
    NetworkController.sharedNetworkController.fetchUsersForSearchTerm(searchBar.text, callback: { (users, errorDescription) -> (Void) in
      if errorDescription == nil {  // <- only execues the next code if there are no errors
        self.users = users!   // <- adds the users
        self.collectionView.reloadData() // <- populates the view
      }
    })
  }
  
  // uses the fancy animationController function to transition to the next page
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if toVC is UserDetailViewController {   // <- if the toVC is the next page, here it is
      return ToUserDetailAnimationController()  // <- then the animation controller will take over
    }
    println("nav was nil")
    return nil
  }
  
  // custom segue to go to the next page
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_USER_DETAIL" {
      let destinationVC = segue.destinationViewController as UserDetailViewController
        let selectedIndexPath = self.collectionView.indexPathsForSelectedItems().first as NSIndexPath  // <- not sure what the first does
         destinationVC.selectedUser = self.users[selectedIndexPath.row]
      }
    }

  
  // prevents you from typing in invalid charcters into the search bar
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
      return text.validate()  // hooks with the extension.swift file
    }
  

}
