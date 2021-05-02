//
//  CustomTableViewDataSource.swift
//  iOSRefactoringChallenge
//
//  Created by Nivedha Rajendran on 01/05/21.
//  Copyright © 2021 SoundCloud. All rights reserved.
//

import UIKit

class CustomTableViewDataSource<Model>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Model, UITableViewCell) -> Void
  var models: [Model]
  private let resuseIdentifier: String
  private let cellConfigurator: CellConfigurator
  
  init(with models: [Model], _ reuseIdentifier: String, and cellConfigurator: @escaping CellConfigurator) {
    
    self.models = models
    self.resuseIdentifier = reuseIdentifier
    self.cellConfigurator = cellConfigurator
  }
  
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

extension CustomTableViewDataSource where Model == Applicable {
  
  static func displayData(for itemList: [Applicable], with cellIdentifier: String) -> CustomTableViewDataSource {
    return CustomTableViewDataSource.init(with: itemList,
                                          cellIdentifier) { (applicable, cell) in
      let trackCell = cell as? PaymentTableViewCell
      trackCell?.payment = applicable
    }
  }
  
}
