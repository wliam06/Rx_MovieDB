//
//  Localization.swift
//  MovieDB
//
//  Created by William on 14/11/21.
//

import Foundation

enum Language: String {
    case english = "en"
    case indonesia = "in"
}

struct Localization {
    static let defaultLanguage: Language = .english

    static func getCurrentLanguageCode() -> String {
        guard let languageCode = Locale.current.languageCode else {
            return defaultLanguage.rawValue
        }
        return Language.init(rawValue: languageCode)?.rawValue ?? defaultLanguage.rawValue
    }

}
