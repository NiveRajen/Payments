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

//Initilizing cache for images
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  
  /// loading image from url and adding image to NSCache and loading it to image view in the cell
  /// - Parameter urlString: urlString - "http://1239f9euf.jpg"
  func loadImageWithCache(for urlString: String) {
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.image = UIImage(named: Constants.defaultImage)
    }
    
    guard let url = URL(string: urlString) else { return }
    
    if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.image = cachedImage as? UIImage
      }
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, jsonResponse, error) in
      if error != nil {
        print(error?.localizedDescription as Any)
        return
      }
      
      guard let data = data else { return }
      
      if let image = UIImage(data: data) {
        
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          imageCache.setObject(image, forKey: urlString as AnyObject)
          self.image = image
        }
      }
    }.resume()
  }
  
  
//  /// Imageview rounded
//  /// - Parameter withBorder: withBorder - Bool
//  func rounded(withBorder: Bool) {
//
//    self.clipsToBounds = true
//    self.layer.cornerRadius = Constants.height/2
//    if (withBorder) {
//      self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
//      self.layer.borderWidth = 1.0
//    } else {
//      self.layer.borderWidth = 0.0
//    }
//  }
}
