//
//  StatementsPresenter.swift
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

protocol StatementsPresentationLogic {
  func presentUserData(response: Statements.UserData.Response)
  func presentStatements(response: Statements.Data.Response)
  func presentStatementsErrorMessage(response: Statements.Data.Response)
}

class StatementsPresenter: StatementsPresentationLogic {
  weak var viewController: StatementsDisplayLogic?
  
  // MARK: Statements Presentation Logic
  
  func presentUserData(response: Statements.UserData.Response) {
    let viewModel = Statements.UserData.ViewModel(user: response.user)
    viewController?.displayUserData(viewModel: viewModel)
  }
  
  func presentStatements(response: Statements.Data.Response) {
    let viewModel = Statements.Data.ViewModel(statements: response.statements, error: response.error)
    viewController?.displayStatements(viewModel: viewModel)
  }
  
  func presentStatementsErrorMessage(response: Statements.Data.Response) {
    let viewModel = Statements.Data.ViewModel(statements: response.statements, error: response.error)
    viewController?.displayStatements(viewModel: viewModel)
  }
}
