//
//  cryptoListTest.swift
//  cdc-assessment-1Tests
//
//  Created by Jacob Zhang on 2024/11/7.
//

import XCTest
import Combine
@testable import cdc_assessment_1

class CryptoRepositoryTests: XCTestCase {
    var viewModel: CryptoListViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = CryptoListViewModel()
        cancellables = []
    }

    func testLoadCryptoData() {
        let expectation = XCTestExpectation(description: "Load crypto data")
        viewModel.$cryptoList
            .dropFirst()
            .sink { cryptoList in
                XCTAssertFalse(cryptoList.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadCryptoData()
        wait(for: [expectation], timeout: 2.0)
    }
}
