//
//  PaymentViewModel.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import Foundation

protocol PaymentDelegate {
  
  func throwError(error: String)
  func reloadData()
}

class PaymentViewModel: NSObject {
  
  var delegate: PaymentDelegate?
  var paymentList: [Applicable]?
  
  func getPayment() {
    
    PaymentAPI.shared.getPaymentMethod { (json, err) in
      DispatchQueue.main.async {
        err == nil ? self.reloadDataWithPaymentList(json ?? []) : self.delegate?.throwError(error: err?.localizedDescription ?? "")
      }
    }
  }
  
  func numberOfRows() -> Int {
    return paymentList?.count ?? 0
  }
  
  func reloadDataWithPaymentList(_ applicable: [Applicable]) {
    self.paymentList = applicable
    self.delegate?.reloadData()
  }
  
  
  func showNoRecords() -> Bool {
    return paymentList == nil ? true : self.numberOfRows() == 0
  }
}
