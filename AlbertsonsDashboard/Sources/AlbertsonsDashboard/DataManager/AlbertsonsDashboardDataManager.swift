//
//  AlbertsonsDashboardDataManager.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import UIKit
import Foundation
import AlbertsonsApis

enum Language: String {
    case eng, ger, ukr, rus, por, esp, cze, ces, fil, urd
}

protocol AlbertsonsDashboardDataManaging {
    func fetchRandonFact(_ count: Int?, language: Language?, completion: @escaping (Result<RandomFact, Failure>) -> Void)
    func fetchRandonFactFor(_ id: Int, language: Language?, completion: @escaping (Result<RandomFact, Failure>) -> Void)
    func fetchRandomCatImage(_ completion: @escaping (Result<UIImage, Failure>) -> Void)
}

extension AlbertsonsDashboardDataManaging {
    
    func fetchRandonFact(_ completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        self.fetchRandonFact(nil,language: nil, completion: completion)
    }
    
    func fetchRandonFactFor(_ id: Int, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        self.fetchRandonFactFor(id, language: nil, completion: completion)
    }
}

struct AlbertsonsDashboardDataManager: AlbertsonsDashboardDataManaging {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    func fetchRandonFact(_ count: Int?, language: Language?, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        var params: [String : String] = [:]
        if let count = count {
            params["count"] = "\(count)"
        }
        
        if let language = language {
            params["lang"] = language.rawValue
        }
        
        fetchRandonFact(params, completion: completion)
    }
    
    func fetchRandonFactFor(_ id: Int, language: Language?, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        var params: [String : String] = ["id" : "\(id)"]
        if let language = language {
            params["lang"] = language.rawValue
        }
        fetchRandonFact(params, completion: completion)
    }
    
    private func fetchRandonFact(_ params: [String : String]? = nil, completion: @escaping (Result<RandomFact, Failure>) -> Void) {
        networkManager.request(url: "", params: params, callBack: completion)
    }
}

extension AlbertsonsDashboardDataManager {
    func fetchRandomCatImage(_ completion: @escaping (Result<UIImage, Failure>) -> Void) {
        let width = Int.random(in: 200...600)
        let height = Int.random(in: 200...600)
        networkManager.request(url: "https://placekitten.com/g/\(width)/\(height)") { response in
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
