//
//  AlbertsonsDashboardViewModel.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation

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
}

extension AlbertsonsDashboardViewModel {
    
    func fetchCatFact(_ completion: @escaping (_ success: Bool) -> Void) {
        dataManager.fetchRandonFact { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self?.catFacts = data
                    completion(true)
                }
            case .failure(let error):
                print("Error with :\(error)")
                completion(false)
            }
        }
    }
}
