//
//  ViewController.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import UIKit

class PaymentListViewController: UIViewController {
  
  @IBOutlet weak var lblNoRecord: UILabel!
  @IBOutlet weak var paymentTableView: UITableView!
  
  //Initializing payment view model
  var paymentViewModel = PaymentViewModel() {
    
    didSet {
      paymentViewModel.delegate = self
      paymentViewModel.getPayment()
    }
  }
  
  private var dataSource: CustomTableViewDataSource<Applicable>? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    
    customInitialization()
  }
  
  func customInitialization() {
    paymentViewModel = PaymentViewModel()
  }
  
  //Reload function to load the data source to table view
  func renderTableViewdataSource(_ applicable: [Applicable]) {
    dataSource = .displayData(for: applicable, with: Constants.paymentTableViewCell)
    self.paymentTableView.dataSource = dataSource
    self.paymentTableView.reloadData()
  }
  
  
}

//MARK: - PAYMENT DELEGATE
extension PaymentListViewController: PaymentDelegate {
  
  func throwError(error: String) {
    showAlert(title: Constants.error, msg: error)
  }
  
  func reloadData() {
    lblNoRecord.isHidden = !paymentViewModel.showNoRecords()
    renderTableViewdataSource(paymentViewModel.paymentList ?? [])
  }
}

