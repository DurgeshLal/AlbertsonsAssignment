//
//  AlbertsonsDashboardCoordinator.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation
import UIKit
import AlbertsonsApis

final public class AlbertsonsDashboardCoordinator: Coordinator {
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController
    private var networkManager: NetworkManaging
    
    public required init(_ navigationController: UINavigationController, container: ServiceResolving) {
        self.navigationController = navigationController
        self.networkManager = container.resolve()
    }
    
    public func start() {
        let storyboard = UIStoryboard(name: "AlbertsonsDashboardViewController", bundle:  Bundle.module)
        let controller = storyboard.instantiateViewController(
            identifier: "AlbertsonsDashboardViewController",
            creator: { [weak self] coder in
                guard let self = self else { return UIViewController() }
                let dataManager = AlbertsonsDashboardDataManager(networkManager: self.networkManager)
                let viewModel = AlbertsonsDashboardViewModel(dataManager)
                return AlbertsonsDashboardViewController(viewModel, coder: coder)
            }
        )
        navigationController.pushViewController(controller, animated: false)
    }
}
