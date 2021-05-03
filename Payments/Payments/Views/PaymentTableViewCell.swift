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
  
  //Inilizing Paymentcell view model
  var paymentCellViewModel: PaymentCellViewModel = PaymentCellViewModel() {
    
    didSet {
      paymentCellViewModel.payment = payment
      paymentCellViewModel.delegate = self
      paymentCellViewModel.downloadImage()
    }
  }
  
  //Initializing Applicable object and populating data
  var payment: Applicable = Applicable() {
    
    didSet {
      lblPaymentName?.text = payment.label
      
      DispatchQueue.main.async {
        self.imgViewLogo.image = UIImage(named: Constants.defaultImage)
      }
    }
  }
  
  //Trait collection function to get the dark/light theme based on user setting
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

//MARK: - PAYMENT CELL DELEGATE
extension PaymentTableViewCell: PaymentCellDelegate {
  
  ///Downloaded image from API
  ///
  /// - Parameter image: download image to load to the cell
  func returnDownloadImage(_ image: UIImage?) {
    
    DispatchQueue.main.async {
      self.imgViewLogo.image = image ?? UIImage(named: Constants.defaultImage)
    }
  }
}
