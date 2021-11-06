//
//  Container+Network.swift
//  MovieDB
//
//  Created by William on 18/09/21.
//

import Foundation

extension DIContainer {
    func registerNetwork() {
        register(type: SessionRequest.self) { _ in
            return NetworkSession()
        }
        register(type: NetworkRequest.self) { (container) -> AnyObject in
            return NetworkSessionRequest(container.resolve(type: SessionRequest.self)!)
        }
    }
}
