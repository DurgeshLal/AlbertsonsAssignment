//
//  AlbertsonsDashboardViewModelTest.swift
//  
//
//  Created by Durgesh Lal on 1/26/23.
//

import Foundation

import XCTest
import AlbertsonsApis
import Combine

@testable import AlbertsonsDashboard

class AlbertsonsDashboardViewModelTest: XCTestCase {

    func testNumberOfRows() {
        let dataManager = AlbertsonsDashboardDataManager(networkManager: MockNetworkManager())
        let viewModel = AlbertsonsDashboardViewModel(dataManager)
        
        viewModel.fetchCatFact { success in
            XCTAssertEqual(viewModel.numberOfRows, 3)
        }
    }
    
    func testItemAtIndex() {
        let dataManager = AlbertsonsDashboardDataManager(networkManager: MockNetworkManager())
        let viewModel = AlbertsonsDashboardViewModel(dataManager)
        
        viewModel.fetchCatFact { success in
            let item = viewModel.catFactAtIndex(0)
            XCTAssertEqual(item, "In the Middle Ages, during the Festival of Saint John, cats were burned alive in town squares.")
        }
    }
}

