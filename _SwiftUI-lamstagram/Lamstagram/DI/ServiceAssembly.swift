//
//  ServiceAssembly.swift
//  Lamstagram
//
//  Created by Jan Kaltoun on 14/01/2020.
//  Copyright © 2020 Jan Kaltoun. All rights reserved.
//

import Swinject

// swiftlint:disable force_unwrapping
final class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserServicing.self) { resolver in
            UserService(
                apiManager: resolver.resolve(APIManaging.self)!
            )
        }
        
        container.register(PostServicing.self) { resolver in
            PostService(
                apiManager: resolver.resolve(APIManaging.self)!
            )
        }
    }
}
