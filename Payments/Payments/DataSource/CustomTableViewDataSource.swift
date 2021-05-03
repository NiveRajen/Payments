//
//  CustomTableViewDataSource.swift
//  iOSRefactoringChallenge
//
//  Created by Nivedha Rajendran on 01/05/21.
//  Copyright © 2021 SoundCloud. All rights reserved.
//

import UIKit


/// Reusable custom table view data source
class CustomTableViewDataSource<Model>: NSObject, UITableViewDataSource {
  
  typealias CellConfigurator = (Model, UITableViewCell) -> Void //Cell configurator using Model and UITableViewCell Class
  var models: [Model]
  private let resuseIdentifier: String
  private let cellConfigurator: CellConfigurator
  
  //Initialization for data Source with model, reuseidentifier and cell configurator
  init(with models: [Model], _ reuseIdentifier: String, and cellConfigurator: @escaping CellConfigurator) {
    
    self.models = models
    self.resuseIdentifier = reuseIdentifier
    self.cellConfigurator = cellConfigurator
  }
  
  //Data Source
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let model = models[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: resuseIdentifier, for: indexPath)
    cellConfigurator(model,cell)
    
    return cell
  }
}

//MARK: - MODEL CLASS VERIFCATION
extension CustomTableViewDataSource where Model == Applicable {
  
  ///Payment cell configuration
  ///
  /// - Parameter itemList: applicable array
  /// - Parameter cellIdentifier: cell identifier
  /// - Returns: Customtableview datasource
  
  static func displayData(for itemList: [Applicable], with cellIdentifier: String) -> CustomTableViewDataSource {
    
    return CustomTableViewDataSource(with: itemList,
                                          cellIdentifier) { (applicable, cell) in
      let paymentCell = cell as? PaymentTableViewCell
      paymentCell?.payment = applicable
      paymentCell?.paymentCellViewModel = PaymentCellViewModel()
    }
  }
  
}
