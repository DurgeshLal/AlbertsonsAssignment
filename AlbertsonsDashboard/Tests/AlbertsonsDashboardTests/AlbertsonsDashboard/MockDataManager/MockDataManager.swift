//
//  MockDataManager.swift
//  
//
//  Created by Durgesh Lal on 1/26/23.
//

import Foundation
import AlbertsonsApis
import Combine
import UIKit

@testable import AlbertsonsDashboard

struct MockLabertsonsDashboardDataManager: AlbertsonsDashboardDataManaging {
    
    private let networkManager: NetworkManaging
    
    init(_ networkManger: NetworkManaging) {
        self.networkManager = networkManger
    }
    
    func fetchRandonFact(_ count: Int?, language: Language?, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        networkManager.request(url: "CatFacts", params: nil, callBack: completion)
    }
    
    func fetchRandonFactFor(_ id: Int, language: Language?, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        networkManager.request(url: "CatFacts", params: nil, callBack: completion)
    }
    
    func fetchRandomCatImage(_ completion: @escaping (Result<UIImage, Failure>) -> Void) {
        
    }
}

