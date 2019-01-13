//
//  LoginInteractor.swift
//  TesteiOSv2
//
//  Created by Brendoon Ryos on 10/01/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic {
  func getLoginTextFieldsData(request: Login.TextFieldsData.Request)
  func login(request: Login.Request)
}

protocol LoginDataStore {
  var user: User? { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
  var presenter: LoginPresentationLogic?
  var worker: LoginWorker?
  
  // MARK: Login Data Store
  var user: User?
  
  // MARK: Login Business Logic
  
  func getLoginTextFieldsData(request: Login.TextFieldsData.Request) {
    worker = LoginWorker()
    let data = worker?.getLoginFieldsData(request: request)
    let response = Login.TextFieldsData.Response(username: data?.username, password: data?.password)
    presenter?.presentFilledLoginTextFields(response: response)
  }
  
  func login(request: Login.Request) {
    if let error = checkLoginRules(userName: request.username, password: request.password) {
      let response = Login.Response(user: nil, error: error)
      presenter?.presentLoginErrorMessage(response: response)
    } else {
      worker = LoginWorker()
      worker?.login(request: request, completion: { result in
        switch result {
        case .success(let user):
          self.user = user
          let response = Login.Response(user: user, error: nil)
          self.presenter?.presentLoginSucceeded(response: response)
        case  .failure(let error):
          let response = Login.Response(user: nil, error: error)
          self.presenter?.presentLoginErrorMessage(response: response)
        }
      })
    }
  }
  
  private func checkLoginRules(userName: String, password: String) -> LoginError? {
    if !userName.isValidCPF && !userName.isValidEmail {
      return LoginError.invalidUsername
    }
    
    if !password.isValidPassword() {
      return LoginError.invalidPassword
    }
    return nil
  }
}