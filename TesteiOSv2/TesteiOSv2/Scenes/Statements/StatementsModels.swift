//
//  StatementsModels.swift
//  TesteiOSv2
//
//  Created by Brendoon Ryos on 12/01/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Statements {
  // MARK: User Data
  
  enum UserData {
    struct Request {}
    
    struct Response {
      let user: User
    }
    
    struct ViewModel {
      let user: User
    }
  }
  
  // MARK: Statements
  enum Data {
    struct Request {
      let userId: Int
    }
    
    struct Response {
      let statements: [Statement]?
      let error: LoginError?
    }
    
    struct ViewModel {
      let statements: [Statement]?
      let error: LoginError?
    }
  }
}
