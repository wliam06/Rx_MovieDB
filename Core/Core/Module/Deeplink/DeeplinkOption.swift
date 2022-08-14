//
//  DeeplinkOption.swift
//  Core
//
//  Created by William on 14/08/22.
//

import Foundation

struct DeeplinkURLConstants {
    static let Movie = "movie"
}

public enum DeeplinkOption {
    case movies
    case movie(Int?)

    public static func build(with userActivity: NSUserActivity) -> DeeplinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let url = userActivity.webpageURL {
            // HERE URL UNIVERSAL LINK
            print("URL", url)
        }
        return nil
    }

    public static func build(with dict: [String: Any]?) -> DeeplinkOption? {

        guard let launchItem = dict?["launch"] as? String else { return nil }
        let itemId = dict?["item_id"] as? Int

        switch launchItem {
        case DeeplinkURLConstants.Movie:
            if itemId != nil {
                return .movie(itemId)
            }
            return .movies
        default:
            return nil
        }
    }

}
