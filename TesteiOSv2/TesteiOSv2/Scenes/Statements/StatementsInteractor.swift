//
//  StatementsInteractor.swift
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

protocol StatementsBusinessLogic {
  func getUserData(request: Statements.UserData.Request)
  func getStatements()
}

protocol StatementsDataStore {
  var user: User! { set get }
}

class StatementsInteractor: StatementsBusinessLogic, StatementsDataStore {
  var presenter: StatementsPresentationLogic?
  var worker: StatementsWorker?
  
  // MARK: Statements Data Store
  var user: User!
  
  // MARK: Statements Business Logic
  
  func getUserData(request: Statements.UserData.Request){
    let response = Statements.UserData.Response(user: user)
    presenter?.presentUserData(response: response)
  }
  
  func getStatements() {
    worker = StatementsWorker()
    let request = Statements.Data.Request(userId: user.id!)
    worker?.fetchStatements(request: request, completion: { result in
      switch result {
      case .success(let statements):
        let response = Statements.Data.Response(statements: statements, error: nil)
        self.presenter?.presentStatements(response: response)
      case .failure(let error):
        let response = Statements.Data.Response(statements: nil, error: error)
        self.presenter?.presentStatements(response: response)
      }
    })
  }
}
