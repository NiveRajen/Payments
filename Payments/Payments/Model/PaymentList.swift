//
//  PaymentList.swift
//  Payments
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import Foundation

//list of applicable payment networks
struct NetworkObject: Codable {
  var applicable: [Applicable]?
  
  enum CodingKeys: String, CodingKey {
    case applicable
  }
}


struct Applicable: Codable {
  var method: String?
  var recurrence: String?
  var grouping: String?
  var redirect: Bool?
  var code: String?
  var registration: String?
  var selected: Bool?
  
  /// Collection of links related to this payment network in scope of the `LIST` session
  var links: Operation?
  
  /// Display label of the payment network.
  var label: String?
  var inputElements: [InputElements]?
  var operationType: String?
  
  enum CodingKeys: String, CodingKey {
    case method
    case recurrence
    case grouping
    case redirect
    case code
    case registration
    case selected
    case links
    case label
    case inputElements
    case operationType
    
  }
}

/// Result of `CHARGE` operation execution with interaction information
struct Operation: Codable {
  var operation: String?
  var validation: String?
  var lang: String?
  var selfOperation: String?
  var logo: String?
  
  enum CodingKeys: String, CodingKey {
    case operation
    case validation
    case lang
    case selfOperation = "self"
    case logo
  }
}

//Input Elements
struct InputElements: Codable {
  var name: String?
  var type: String?
  
  enum CodingKeys: String, CodingKey {
    case name
    case type
  }
}
