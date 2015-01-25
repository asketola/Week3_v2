//
//  Profile.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/24/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

struct Profile {
  let name : String
  let userName : String
  let avatarURL : String
  var avatarImage : UIImage?
  let company : String
  let city : String
  let joinedDate : String
  let followersNumberInt : Int
  let followersNumber : String?
  let starredURL : String
  let starredNumber : String?
  let followingNumberInt : Int
  let followingNUmber : String?
  
  init (jsonDictionary : [String : AnyObject]) {
    self.name = jsonDictionary["login"] as String
    self.userName = jsonDictionary["name"] as String
    self.avatarURL = jsonDictionary["avatar_url"] as String
    self.company = jsonDictionary["company"] as String
    self.city = jsonDictionary["location"] as String
    self.joinedDate = jsonDictionary["j"] as String
    self.followersNumberInt = jsonDictionary["followers"] as Int
    // self.starredNumber = jsonDictionary["f"] as String
    self.starredURL = jsonDictionary["starred_url"] as String
    self.followingNumberInt = jsonDictionary["following"] as Int
    
    println("name: \(name)")
    println("userName: \(userName)")
    println("avatarURL: \(avatarURL)")
    println("company: \(company)")
    println("city: \(city)")
    println("joinedDate: \(joinedDate)")
    println("followersNumberInt: \(followersNumberInt)")
    println("starredURL: \(starredURL)")
    println("followingNumberURL: \(followingNumberInt)")
    
  }
}
