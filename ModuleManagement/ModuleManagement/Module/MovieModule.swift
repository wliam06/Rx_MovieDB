//
//  MovieModule.swift
//  ModuleManagement
//
//  Created by William on 09/08/22.
//

import Foundation

public protocol MovieListManageModule {
    func start()
}

public protocol MovieDetailManageModule {
    func start(movieId: Int?)
}
