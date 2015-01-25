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
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
    cell.imageView.image = nil
    var user = self.users[indexPath.row]
    if user.avatarImage == nil {
      NetworkController.sharedNetworkController.fetchAvatarImageForURL(user.avatarURL, completionHandler: { (image) -> (Void) in
        cell.imageView.image = image
        user.avatarImage  = image
        self.users[indexPath.row] = user
      })
    } else {
      cell.imageView.image = user.avatarImage
    }
    return cell
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    
    NetworkController.sharedNetworkController.fetchUsersForSearchTerm(searchBar.text, callback: { (users, errorDescription) -> (Void) in
      if errorDescription == nil {
        self.users = users!
        self.collectionView.reloadData()
      }
    })
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    // if fromVC is SearchUsersViewController {
    println("func navigationsControllerAnimation ran")
    if toVC is UserDetailViewController {
      println("Yes, we got to the if toVC")
      return ToUserDetailAnimationController()
    }
    println("nav was nil")
    return nil
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_USER_DETAIL" {
      if let destinationVC = segue.destinationViewController as? UserDetailViewController {
      let selectedIndexPath = self.collectionView.indexPathsForSelectedItems().first as NSIndexPath
      destinationVC.selectedUser = self.users[selectedIndexPath.row]
      } else {
        self.navigationController?.delegate = nil
      }
    }
  }
  
  // Try out the push code vs the SEGUE command 
  
  // prevents you from typing in invalid charcters into the search bar
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
      return text.validate()  // hooks with the extension.swift file
    }
  

}
