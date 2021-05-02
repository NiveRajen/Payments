//
//  PaymentTableViewCell.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
  @IBOutlet weak var lblPaymentName: UILabel!
  @IBOutlet weak var imgViewLogo: UIImageView!
  @IBOutlet weak var containerView: UIView!
  
  var payment: Applicable = Applicable() {
    didSet {
      lblPaymentName?.text = payment.label
      
      DispatchQueue.global(qos: .background).async { [weak self] in
        
        guard let self = self else { return }
        if let imageUrlString = self.payment.links?.logo {
          self.imgViewLogo.loadImageWithCache(for: imageUrlString)
        }
      }
    }
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    super.traitCollectionDidChange(previousTraitCollection)
    
    switch traitCollection.userInterfaceStyle {
    case .light, .unspecified:
      self.containerView.viewShadowColor = .lightGray
    case .dark:
      self.containerView.viewShadowColor = .black
    @unknown default:
      fatalError()
    }
  }
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
