//
//  AppContainer.swift
//  MovieDB
//
//  Created by William on 12/09/21.
//

import Foundation

protocol Dependency {
    var network: NetworkRequest { get }
}

struct AppDependency: Dependency {
    var network: NetworkRequest {
        return NetworkSessionRequest()
    }
}

//class AppContainer {
////    var container: Container
//    var resolver: Resolver
//    init() {
//         let network = Container()
//            .register(SessionRequest.self,
//                      instance: NetworkSession()
//            )
//            .register(NetworkRequest.self) { resolver in
//                let session = NetworkSession()
//                return NetworkSessionRequest(session)
//            }
//            .register(TabBarCoordinator.self,
//                      instance: MovieTabCoordinator())
////        let coordinator = Container()
////            .register(Presentable.self,
////                      instance: Router())
////            .register(Router.self, instance: )
//
//        let arrayOfResolver: Resolver = [
//            network
//        ]
//    }
//}
