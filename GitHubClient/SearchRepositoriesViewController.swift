//
//  SearchRepositoriesViewController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/19/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class SearchRepositoriesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!

  var repos = [Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // initiate variables
      self.tableView.dataSource = self
      self.searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
  
  // UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // fulfills tableView requirement to tell how many rows to make
    return self.repos.count
  }
  
  
  // fulfills tableView requirement to tell how to draw the cells
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepoCell
    // return cell
    
    let repository = self.repos[indexPath.row]  // defines the single repo
//    println("\(repository)")
//
    // Puts on the labels
    cell.repoNameLabel.text = repository.repoName
    cell.repoDescriptionLabel.text = repository.repoDescription
    cell.repoDateLabel.text = repository.repoDate
    cell.programmingLanguageLabel.text = repository.repoLanguage
    
    return cell
  }
  
  // prevents you from typing in invalid charcters into the search bar
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validate()  // hooks with the extension.swift file, prevents invalid text input
  }
  
  // UISearchBarDelegate
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    println(searchBar.text)
    NetworkController.sharedNetworkController.fetchRepositoriesForSearchTerm(searchBar.text, callback: { (repositories, errorDescription) -> (Void) in
    self.repos = repositories!
    self.tableView.reloadData() // reloads the cells
    })
    searchBar.resignFirstResponder()  // dismisses the keyboard
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "SHOW_WEB" {
        let destinationVC = segue.destinationViewController as WebViewController
        let selectedIndexPath = self.tableView.indexPathForSelectedRow()
        let repo = self.repos[selectedIndexPath!.row]
        destinationVC.url = repo.url
      }
    }
  
  
    }
