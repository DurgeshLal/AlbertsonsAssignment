//
//  AlbertsonsDashboardDataManager.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation
import AlbertsonsApis

protocol AlbertsonsDashboardDataManaging {
    func fetchRandonFact(_ completion: @escaping (Result<RandomFact, Failure>) -> Void)
}

struct AlbertsonsDashboardDataManager: AlbertsonsDashboardDataManaging {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    func fetchRandonFact(_ completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        networkManager.request(url: "", callBack: completion)
    }
}
