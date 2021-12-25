//
//  AppDependency.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import UIKit

extension Dependency {
    func registerAllDependencies() {
        registerNetwork()
        registerNowPlaying()
    }
}
