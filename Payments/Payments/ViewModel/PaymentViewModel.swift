//
//  PaymentViewModel.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import Foundation

//MARK: - PAYMENTDELEGATE
protocol PaymentDelegate {
  
  func throwError(error: String)
  func reloadData()
}

class PaymentViewModel: NSObject {
  
  var delegate: PaymentDelegate?
  var paymentList: [Applicable]?
  
  ///Get payment method list from API
  ///
  func getPayment() {
    
    PaymentAPI.shared.getPaymentMethod { (json, err) in
      DispatchQueue.main.async {
        err == nil ? self.reloadDataWithPaymentList(json ?? []) : self.delegate?.throwError(error: err?.localizedDescription ?? "")
      }
    }
  }
  
  //Returns number of rows for the table view data Source
  func numberOfRows() -> Int {
    return paymentList?.count ?? 0
  }
  
  ///Reload data source using paymentList Delegate
  /// - Returns: array of applicable object
  func reloadDataWithPaymentList(_ applicable: [Applicable]) {
    self.paymentList = applicable
    self.delegate?.reloadData()
  }
  
  ///Show no records
  /// - Returns: A boolen to hide/show no records label
  func showNoRecords() -> Bool {
    return paymentList == nil ? true : self.numberOfRows() == 0
  }
}
