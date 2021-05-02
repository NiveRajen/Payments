//
//  PaymentAPI.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import Foundation

class PaymentAPI {
  static let shared = PaymentAPI()
  
  func getPaymentMethod(completionHandler: @escaping(_ result: [Applicable]?, _ error: Error?) -> Void) {
    let urlComp = NSURLComponents(string: Constants.baseUrlString + Constants.listPath)!
    var request = URLRequest(url: urlComp.url!)
    request.httpMethod = Constants.getMethod
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, res, err) in
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          if let network = json[Constants.networks] as? [String: Any] {
            if let networkData = try JSONSerialization.data(withJSONObject: network, options: []) as Data? {
              let paymentDict = try JSONDecoder().decode(Network.self, from: networkData)
              completionHandler(paymentDict.applicable, err)
            }
          }
        }
      } catch {
        completionHandler(nil, err)
      }
    }
    task.resume()
  }
}
