//
//  Injected+Network.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Networking

// MARK: - Network Request
private struct NetworkRequestProviderKey: InjectionKey {
    static var currentValue: NetworkRequest = NetworkSessionRequest()
}

// MARK: - Network Session
private struct NetworkSessionProviderKey: InjectionKey {
    static var currentValue: SessionRequest = NetworkSession.shared
}

extension InjectedValue {
    public var sessionRequest: SessionRequest {
        get { Self[NetworkSessionProviderKey.self] }
        set { Self[NetworkSessionProviderKey.self] = newValue }
    }

    public var networkRequest: NetworkRequest {
        get { Self[NetworkRequestProviderKey.self] }
        set { Self[NetworkRequestProviderKey.self] = newValue }
    }
}
