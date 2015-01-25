//
//  Repository.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/19/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import Foundation

struct Repository {
  let name : String
 // let author : String
  let url : String
  var repoName : String
  var repoDescription : String
  var repoDate : String
  var repoLanguage : String?
 
  init(jsonDictionary : [String : AnyObject]) {
    self.name = jsonDictionary["name"] as String
  //  self.author = jsonDictionary["author"] as String // <- is this supposed to be my name?
    self.url = jsonDictionary["html_url"] as String
      self.repoName = jsonDictionary["full_name"] as String
      self.repoDescription = jsonDictionary["description"] as String
      self.repoDate = jsonDictionary["pushed_at"] as String
      self.repoLanguage = jsonDictionary["language"] as? String
    
    println("The name is: \(name)")
//    println("The author is: \(author)")
    println("The url is: \(url)")
    println("the repoName is: \(repoName)")
    println("The repoDescription is: \(repoDescription)")
    println("The repoDate is: \(repoDate)")
    println("The repoLanguage is: \(repoLanguage)")
  }
}
