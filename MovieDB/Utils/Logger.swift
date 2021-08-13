//
//  Logger.swift
//  MovieDB
//
//  Created by William on 13/08/21.
//

import Foundation
import os.log

/// https://www.avanderlee.com/workflow/oslog-unified-logging/
final class Logger {
    static func error(_ message: String) {
        os_log("%@", log: .default, type: .error, message)
    }

    static func debug(_ message: String) {
        os_log("%@", log: .default, type: .debug, message)
    }

    static func info(_ message: String) {
        os_log("%@", log: .default, type: .info, message)
    }
}
