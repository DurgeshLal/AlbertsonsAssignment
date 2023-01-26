//
//  AlbertsonsDashboardDataManager.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import UIKit
import Foundation
import AlbertsonsApis

protocol AlbertsonsDashboardDataManaging {
    func fetchRandonFact(_ count: Int?, completion: @escaping (Result<RandomFact, Failure>) -> Void)
    func fetchRandonFactFor(_ id: Int, completion: @escaping (Result<RandomFact, Failure>) -> Void)
    func fetchRandomCatImage(_ completion: @escaping (Result<UIImage, Failure>) -> Void)
}

extension AlbertsonsDashboardDataManaging {
    func fetchRandonFact(_ completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        self.fetchRandonFact(nil, completion: completion)
    }
}

struct AlbertsonsDashboardDataManager: AlbertsonsDashboardDataManaging {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    func fetchRandonFact(_ count: Int?, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        var param: [String : String] = [:]
        if let count = count {
            param["count"] = "\(count)"
        }
        fetchRandonFact(param, completion: completion)
    }
    
    func fetchRandonFactFor(_ id: Int, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        fetchRandonFact(["id" : "\(id)"], completion: completion)
    }
    
    private func fetchRandonFact(_ params: [String : String]? = nil, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        networkManager.request(url: "", params: params, callBack: completion)
    }
}

extension AlbertsonsDashboardDataManager {
    func fetchRandomCatImage(_ completion: @escaping (Result<UIImage, Failure>) -> Void) {
        networkManager.request(url: "https://placekitten.com/g/200/300") { response in
            switch response {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(Failure.parsingError))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
