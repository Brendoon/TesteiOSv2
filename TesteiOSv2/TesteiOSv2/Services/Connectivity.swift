//
//  Connectivity.swift
//  TesteiOSv2
//
//  Created by Brendoon Ryos on 13/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Alamofire

class Connectivity {
  class func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
  }
}
