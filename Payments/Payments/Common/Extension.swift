//
//  Extension.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import UIKit

//MARK:- UIView
extension UIView {
  
  @IBInspectable var viewCornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  /*  Drop shadow
   We can use this variable to add shaodow to respective view in storyboard
   */
  @IBInspectable var viewShadowColor: UIColor? {
    get {
      return UIColor(cgColor: layer.shadowColor!)
    } set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable var viewmaskToBounds: Bool {
    get {
      return layer.masksToBounds
    }
    set {
      layer.masksToBounds = newValue
    }
  }
  
  @IBInspectable var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    } set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    } set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    } set {
      layer.shadowOpacity = newValue
    }
  }
}


//MARK: UIVIEW CONTROLLER
extension UIViewController {
  func showAlert(title: String?, msg: String?)  {
    
    let okAction = UIAlertAction(title: Constants.ok, style: .default, handler: nil)
    
    guard let alertMessage = msg, let alertTitle = title?.capitalized else { return }
    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    
    DispatchQueue.main.async {
      
      alert.addAction(okAction)
      self.present(alert, animated: true, completion: nil)
    }
  }
}

//MARK: DATA
extension Data {
  func json(deletingKeyPaths keyPaths: String...) throws -> Data {
    let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject
    
    for keyPath in keyPaths {
      decoded.setValue(nil, forKeyPath: keyPath)
    }
    
    return try JSONSerialization.data(withJSONObject: decoded)
  }
}

