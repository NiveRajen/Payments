//
//  PaymentAPI.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import Foundation
import UIKit

class PaymentAPI {
  
  static let shared = PaymentAPI()
  let imageCache = NSCache<AnyObject, AnyObject>()
  
  func getPaymentMethod(completionHandler: @escaping(_ result: [Applicable]?, _ error: Error?) -> Void) {
    
    if Reachability.isConnectedToNetwork() {
      
      let urlComp = NSURLComponents(string: Constants.baseUrlString + Constants.listPath)!
      var request = URLRequest(url: urlComp.url!)
      request.httpMethod = Constants.getMethod
      
      let session = URLSession.shared
      let task = session.dataTask(with: request) { (data, res, err) in
          //Check for valid data and not nil values
          guard let data = data, let httpResponse = res as? HTTPURLResponse, err == nil else {
            
            completionHandler(nil, err)
            return
          }
          
          //Check for status code
          guard 200 ..< 300 ~= httpResponse.statusCode else {
            
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.serverError])
            
            completionHandler(nil, error)
            return
          }
          
          let serializeData = SerializePaymentData(data: data)
          completionHandler(serializeData.jsonSerialize().0, serializeData.jsonSerialize().1)
      }
      task.resume()
      
    } else {
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.NoInternet])
      completionHandler(nil, error)
    }
  }
  
  
  /// loading image from url and adding image to NSCache and loading it to image view in the cell
  /// - Parameter urlString: urlString - "http://1239f9euf.jpg"
  func loadImageWithCache(for urlString: String, completionHandler: @escaping(_ image: UIImage) -> Void) {
    
    guard let url = URL(string: urlString) else { return }
    
    if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
      completionHandler(cachedImage)
    }
    
    URLSession.shared.dataTask(with: url) { (data, jsonResponse, error) in
      
      if error != nil {
        
        print(error?.localizedDescription as Any)
        return
      }
      
      guard let data = data else { return }
      
      if let image = UIImage(data: data) {
        
        self.imageCache.setObject(image, forKey: urlString as AnyObject)
        completionHandler(image)
      }
    }.resume()
  }
}

class SerializePaymentData {
  
  var data: Data
  
  init(data: Data) {
    
    self.data = data
  }
  
  func jsonSerialize() -> ([Applicable]?, Error?) {
    
    do {
      if let json = try JSONSerialization.jsonObject(with: self.data, options: []) as? [String: Any] {
        
        if let network = json[Constants.networks] as? [String: Any] {
          
          if let networkData = try JSONSerialization.data(withJSONObject: network, options: []) as Data? {
            
            let paymentDict = try JSONDecoder().decode(NetworkObject.self, from: networkData)
            
            return (paymentDict.applicable, nil)
          }
        }
      }
    } catch {
      
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.dataTypeError])
      return (nil, error)
    }
    
    return (nil, nil)
  }
}

