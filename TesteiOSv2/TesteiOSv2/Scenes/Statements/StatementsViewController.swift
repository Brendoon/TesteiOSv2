//
//  StatementsViewController.swift
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

protocol StatementsDisplayLogic: class {
  func displayUserData(viewModel: Statements.UserData.ViewModel)
  func displayStatements(viewModel: Statements.Data.ViewModel)
  func displayStatementsErrorMessage(viewModel: Statements.Data.ViewModel)
}

final class StatementsViewController: UIViewController {
  var interactor: StatementsBusinessLogic?
  var router: (NSObjectProtocol & StatementsRoutingLogic & StatementsDataPassing)?
  var dataSource: StatementsDataSource?
  
  override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

  // MARK: IBOutlets
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var accountLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: IBActions
  
  @IBAction func logout(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = StatementsInteractor()
    let presenter = StatementsPresenter()
    let router = StatementsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: Setup View
  
  private func setupView() {
    let request = Statements.UserData.Request()
    interactor?.getUserData(request: request)
    dataSource = StatementsDataSource()
    dataSource?.tableView = tableView
    tableView.dataSource = dataSource
    interactor?.getStatements()
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
  }
  
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    interactor?.getStatements()
    refreshControl.endRefreshing()
  }
}

extension StatementsViewController: StatementsDisplayLogic {
  func displayUserData(viewModel: Statements.UserData.ViewModel) {
    userNameLabel.text = viewModel.user.name
    accountLabel.text = viewModel.user.agency! + " / " + viewModel.user.bankAccount!
    balanceLabel.text = Double.toCurrency(value: viewModel.user.balance!)
  }
  
  func displayStatements(viewModel: Statements.Data.ViewModel) {
    dataSource?.statements = viewModel.statements!
  }
  
  func displayStatementsErrorMessage(viewModel: Statements.Data.ViewModel) {
    let error = viewModel.error!
    alert(message: error.description.message, title: error.description.title)
  }
}