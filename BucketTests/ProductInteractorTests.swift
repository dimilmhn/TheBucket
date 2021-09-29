//
//  ProductInteractorTests.swift
//  BucketTests
//
//  Created by Dimil T Mohan on 2021/09/29.
//

import XCTest
import Mockingjay
@testable import Bucket

class ProductInteractorTests: XCTestCase {
    var systemUnderTest: ProductInteractor!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRetrieveSuccessful() {
        let expectation = self.expectation(description: "Retrieve Product List")
        let mockURL = "https://mockURLSuccessfullRequest"
        let data = JsonLoader.data(withResource: "ProductRetrievePositiveResponse")!
        stub(http(.get, uri: mockURL), jsonData(data))
        systemUnderTest.retrieveProductList(service: ProductService(mockURL), completion: { items in
            XCTAssertNotNil(items)
            XCTAssert(items?.count == 77)
            expectation.fulfill()
        }, failure: { [weak self] error in
            XCTFail("Failed to retrieve profiles")
        })
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
    func testRetrieveFailsFromEmptyResponse() {
        let expectation = self.expectation(description: "Retrieve Empty Product List")
        let mockURL = "https://mockURLEmptyRequest"
        let data = JsonLoader.data(withResource: "ProductRetrieveEmptyResponse")!
        stub(http(.get, uri: mockURL), jsonData(data))
        systemUnderTest.retrieveProductList(service: ProductService(mockURL), completion: { items in
            XCTAssert(items?.count == 0, "No products should have been retrieved")
            expectation.fulfill()
        }, failure: { error in
            XCTFail("failure should not be called")
        })
        waitForExpectations(timeout: 3.0, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
