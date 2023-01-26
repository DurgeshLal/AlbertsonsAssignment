//
//  Coordinator.swift
//  
//
//  Created by Durgesh Lal on 1/26/23.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
