//
//  NetworkController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/19/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class NetworkController {
  
  // Makes the NetworkController a Singleton
  class var sharedNetworkController : NetworkController {
    struct Static {
      static let instance : NetworkController = NetworkController()  // the let allows you to reun this once, and it set up for the rest of the time
    }
    return Static.instance
  }
  
  let clientSecret = "17ae7d699a01988e198cf212c21d5277b1fbdd38"  // <- from the github app registration
  let clientID = "b6b96917364365d8c3fb"   // <- from the github app registration
  var urlSession : NSURLSession
  let accessTokenUserDefaultsKey = "accessToken"  // <- your phone stores this
  var accessToken : String?
  
  let imageQueue = NSOperationQueue()
  
  init() {
    let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    
    self.urlSession = NSURLSession(configuration: ephemeralConfig)
    if let accessToken = NSUserDefaults.standardUserDefaults().objectForKey(self.accessTokenUserDefaultsKey) as? String {
      self.accessToken = accessToken
    }
  }

  // Step 1 - request a token
  func requestAccessToken() {
    let url = "https://github.com/login/oauth/authorize?client_id=\(self.clientID)&scope=user,repo"
    UIApplication.sharedApplication().openURL(NSURL(string: url)!)
  }
  
  // Step 2 - it answers you back
  func handleCallBackUrl(url: NSURL) {
    let code = url.query
    println(code!)
    
    // this is one way to pass back info in a POST, via passing items as paramters in a url
    
//    let oauthUrl = "https://github.com/login/oauth/access_token?\(code!)&client_secret=\(self.clientSecret)"
//    let postRequest = NSMutableURLRequest(URL: NSURL (string: oauthUrl)!)
//    postRequest.HTTPMethod = "POST"
//    //postRequest.HTTPBody
    
    // This is the 2nd way to pass back info with a POST, and this is passing back info in the body of a HTTP request
    
    // Step 3 - after you get back the ok, you send the request
    let bodyString = "\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)"
    let bodyData = bodyString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    let length = bodyData!.length
    let postRequest = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token")!)
    postRequest.HTTPMethod = "POST"
    postRequest.setValue("\(length)", forHTTPHeaderField: "Content-Length")
    postRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    postRequest.HTTPBody = bodyData

    // Step 4 - lets you know if your request was good, so you get a response
    let dataTask = self.urlSession.dataTaskWithRequest(postRequest, completionHandler: { (data, response, error) -> Void in
      
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:  // if the response was good, you get to filter through the response
              let tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)  // decode it into a string(?)
              println(tokenResponse)
              
              let accessTokenComponent = tokenResponse?.componentsSeparatedByString("&").first as String  // seperate the string by the &s and keep the left side
              let accessToken = accessTokenComponent.componentsSeparatedByString("=").last  // seperate the string by the =s and keep the right
              println(accessToken!) // prints your token so you can see it its good
              
              NSUserDefaults.standardUserDefaults().setObject(accessToken!, forKey: self.accessTokenUserDefaultsKey)  // takes the access token and puts it as the key(?)
              NSUserDefaults.standardUserDefaults().synchronize()  // <- saves the token key somewhere safe (?)
              
            default:
              println("default case")
            }
        }
      }
      println(response)
    })
    dataTask.resume()
    
  }
  
  // Gets the repositories you are looking for, uses searchTerm, defined in your seachBar, gives back a repository (?)
  func fetchRepositoriesForSearchTerm(searchTerm : String, callback : ([Repository]?, String?) -> (Void)) {
    
    let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchTerm)") // the address, from github
    
    let request = NSMutableURLRequest(URL: url!)  // <- sends the request
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")  // <- calls up the token we saved
    //let url = NSURL(string: "http://127.0.0.1.3000")
    
    let dataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error == nil {  // if we get no errors sent, e continue
        if let httpResponse = response as? NSHTTPURLResponse {  // puts the response we get back into the variable "httpResponse"
          switch httpResponse.statusCode {  // looks at the status code included in the response
          case 200...299:   // the good codes
           // println(httpResponse)
            // converts the response into json
            let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as [String : AnyObject]
            var repos = [Repository]()   // setsup the array repos, and defines it as using the class Repository
            if let itemsArray = jsonDictionary["items"] as? [[String : AnyObject]] { // goes into the Dictionary "item" (its a dictionary inside a dictionary) and makes that an array
              for object in itemsArray { // loops through the elements in the array
                let repo = Repository(jsonDictionary: object) // defines a single element using the class
                repos.append(repo) // adds it to the array
              }
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in  // brings this all back to the main thread
                callback(repos, nil)
              })
            }
           // println(jsonDictionary)
          default:
            println("defualt")
          }
        }
      }
      })
    dataTask.resume()
  }
  
  func fetchUsersForSearchTerm(searchTerm : String, callback : ([User]?, String?) -> (Void)) {
    
    let url = NSURL(string: "https://api.github.com/search/users?q=\(searchTerm)")
    
    let request = NSMutableURLRequest(URL: url!)
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")
    //let url = NSURL(string: "http://127.0.0.1.3000")
    println(self.accessToken)
    
    let dataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
          case 200...299:
//            println(httpResponse)
            if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject] {
            if let itemsArray = jsonDictionary["items"] as? [[String : AnyObject]] {
              
              var users = [User]()
              
              for item in itemsArray {
                let user = User(jsonDictionary: item)
                users.append(user)
              }
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                callback(users, nil)
              })
            }
            }
          default:
            println("default case on user search, status code: \(httpResponse.statusCode)")
          }
        }
      } else {
        println(error.localizedDescription)
      }
      })
    dataTask.resume()
    }
  
  func fetchAvatarImageForURL(url : String, completionHandler : (UIImage) -> (Void)) {
    
    let url = NSURL(string: url)
    
    self.imageQueue.addOperationWithBlock { () -> Void in
      let imageData = NSData(contentsOfURL: url!)
      let image = UIImage(data: imageData!)
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(image!)
      })
    }
  }
  
  //func fetchMyProfile(username : String, callback : ([Profile]?, String?) -> (Void)) {
    func fetchMyProfile(callback : ([Profile]?, String?) -> (Void)) {
    
    let profileURL = NSURL(string: "https://api.github.com/user")
    
    let request = NSMutableURLRequest(URL: profileURL!)
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")

    println(self.accessToken)
    
    let dataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
          case 200...299:
                      //  println(httpResponse)
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
              
                var profile = [Profile]()
                
                for object in jsonArray { // I don't think I need this part, becuse there is only 1 profile, but I'm not clear on where/how things are added to my Profile. . . . . . .
                  if let jsonDictionary = object as? [String : AnyObject] {
                    let myProfile = Profile(jsonDictionary: jsonDictionary)
                    profile.append(myProfile)
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  callback(profile, nil)
                })
              }
            }
          default:
            println("default case on user search, status code: \(httpResponse.statusCode)")
          }
        }
      } else {
        println(error.localizedDescription)
      }
    })
    dataTask.resume()
  }
  
  func fetchProfileImageForURL(url : String, completionHandler : (UIImage) -> (Void)) {
    
    let profileURL = NSURL(string: url)
    
    self.imageQueue.addOperationWithBlock { () -> Void in
      let imageData = NSData(contentsOfURL: profileURL!)
      let image = UIImage(data: imageData!)
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(image!)
      })
    }
  }
} // final close bracket
