//
//  PaymentCellViewModel.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import Foundation
import UIKit

//MARK: PaymentCellDelegate
protocol PaymentCellDelegate {
  
  func returnDownloadImage(_ image: UIImage?)
}

class PaymentCellViewModel: NSObject {
  var delegate: PaymentCellDelegate? //Initalizing Payment Delegate
  var payment: Applicable?
  
  ///DownloadImage to load logo from API and pass using delegate
  func downloadImage() {
    
    DispatchQueue.global(qos: .background).async { [weak self] in
      
      guard let self = self else { return }
      PaymentAPI.shared.loadImageWithCache(for: self.payment?.links?.logo ?? "") { (image) in
        DispatchQueue.main.async {
          self.delegate?.returnDownloadImage(image)
        }
      }
    }
  }
}
