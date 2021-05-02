//
//  PaymentsTests.swift
//  PaymentsTests
//
//  Created by Nivedha Rajendran on 02/05/21.
//

import XCTest
@testable import Payments

class PaymentsTests: XCTestCase {
  
  var paymentVC: PaymentListViewController?

    override func setUpWithError() throws {
      let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
      paymentVC = storyBoard.instantiateViewController(identifier: "PaymentListViewController")
      _ = paymentVC?.view
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
      
        self.measure {
          test_PaymentAPI()
            // Put the code you want to measure the time of here.
        }
    }
  
  func test_PaymentAPI() {
    
    let urlComp = NSURLComponents(string: Constants.baseUrlString + Constants.listPath)!
    var request = URLRequest(url: urlComp.url!)
    
    XCTAssertNotNil(request.url)
    request.httpMethod = Constants.getMethod
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, res, err) in
      do {
        XCTAssertNotNil(res)
        XCTAssertTrue(res is HTTPURLResponse)
        XCTAssertNotNil(data)
        
        if let httpUrlResponse = res as? HTTPURLResponse {
          XCTAssertEqual(httpUrlResponse.statusCode, 200)
        }
        
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          
          if let network = json[Constants.networks] as? [String: Any] {
            
            if let networkData = try JSONSerialization.data(withJSONObject: network, options: []) as Data? {
              
              let paymentDict = try JSONDecoder().decode(NetworkObject.self, from: networkData)
              
              XCTAssertNotNil(paymentDict)
            }
          }
          XCTAssertNotNil(json)
        }
      } catch {
        print("Throw error")
      }
    }
    task.resume()
  }
  
  //MARK: TEST CASES FOR MAP VIEW
  func test_CheckForTableView() {
    XCTAssertNotNil(paymentVC?.paymentTableView)
    XCTAssertNotNil(paymentVC?.paymentTableView.delegate is PaymentListViewController)
    XCTAssertNotNil(paymentVC?.paymentTableView.dataSource is CustomTableViewDataSource<Applicable>)
  }
}
