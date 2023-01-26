//
//  ApplicationBootstrap.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation
import AlbertsonsApis

public class ApplicationBootstrap {
    public static func createApplicationBootstrap() -> ServiceResolving{
        let container: ServiceResolving = Container()
        container.register(NetworkManaging.self) { _ in NetworkManager(EnumEnvironment.prod) }
        container.register(FormatManaging.self) { _ in FormatManager() }
        container.register(DateManaging.self) { _ in DateManager() }
        return container
    }
}
