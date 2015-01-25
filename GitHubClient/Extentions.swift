//
//  Extentions.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/22/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import Foundation

extension String {
  
  func validate() -> Bool {  // makes sure you are typing in valid text
    let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: nil)
    let elements = countElements(self)
    let range = NSMakeRange(0, elements)
    let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
    
    if matches > 0 {
      return false
    }
    return true
  }
  
}
