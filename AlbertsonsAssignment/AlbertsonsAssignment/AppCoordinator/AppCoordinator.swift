//
//  AppCoordinator.swift
//  AlbertsonsAssignment
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation
import UIKit
import AlbertsonsApis
import AlbertsonsDashboard
import AlbertsonsApplicationBootstrap

final class AppCoordinator: NSObject, Coordinator {
    internal var children: [Coordinator] = []
    internal var navigationController: UINavigationController
    private let container: ServiceResolving
    required init(_ navigationController: UINavigationController, container: ServiceResolving) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let coordinator = AlbertsonsDashboardCoordinator(navigationController, container: container)
        children.append(coordinator)
        coordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        if let index = children.firstIndex(where: { $0 === child }) {
            children.remove(at: index)
        }
    }
}

// Using Package to manage code better and make it modular
// Use Swift UI and Combine


