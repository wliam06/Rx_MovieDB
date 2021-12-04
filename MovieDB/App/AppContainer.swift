//
//  AppContainer.swift
//  MovieDB
//
//  Created by William on 12/09/21.
//

import Foundation

extension Container {
    func registerAllDependencies() {
        registerNetwork()
        registerHomeContainer()
    }
}
