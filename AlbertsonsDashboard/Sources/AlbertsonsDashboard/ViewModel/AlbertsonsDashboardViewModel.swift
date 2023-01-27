//
//  AlbertsonsDashboardViewModel.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation
import UIKit

class AlbertsonsDashboardViewModel {
    
    private let dataManager: AlbertsonsDashboardDataManaging
    private var catFacts: [String] = []
    
    required init(_ dataManager: AlbertsonsDashboardDataManaging) {
        self.dataManager = dataManager
    }
}

extension AlbertsonsDashboardViewModel {
    var numberOfRows: Int { catFacts.count }
    
    func catFactAtIndex(_ index: Int) -> String? {
        catFacts[index]
    }
    
    func clearDataSource() {
        catFacts = []
    }
}

extension AlbertsonsDashboardViewModel {
    
    func fetchCatFact(_ completion: @escaping (_ success: Bool) -> Void) {
        // Fetch a random fact in English
        dataManager.fetchRandonFact() { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self?.catFacts += data
                    completion(true)
                }
            case .failure(let error):
                print("Error with :\(error)")
                completion(false)
            }
        }
        
        // Fetch a random fact in foreign English
        dataManager.fetchRandonFact(1, language: .ger) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self?.catFacts += data
                    completion(true)
                }
            case .failure(let error):
                print("Error with :\(error)")
                completion(false)
            }
        }
    }
    
    func fetchCatImage(_ completion: @escaping (_ image: UIImage?) -> Void) {
        dataManager.fetchRandomCatImage { response in
            switch response {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Error with : \(error)")
                completion(nil)
            }
        }
    }
}
