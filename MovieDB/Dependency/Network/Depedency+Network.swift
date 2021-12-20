//
//  Container+Network.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

extension Dependency {
    func registerNetwork() {
        register(type: SessionRequest.self) { _ in
            return NetworkSession()
        }
        register(type: NetworkRequest.self) { (container) -> AnyObject in
            return NetworkSessionRequest(
                container.resolve(type: SessionRequest.self)
            )
        }
    }
}
