//
//  NetwokReachability.swift
//  MovieDB
//
//  Created by William on 13/08/21.
//

import Alamofire

final class NetworkReachability {
    static let shared = NetworkReachability()
    let reachabilityManager = NetworkReachabilityManager()
    private var alertView = AlertView.shared

    func startNetworkMonitoring() {
      reachabilityManager?.startListening { status in
        switch status {
        case .notReachable:
            self.showOfflineAlert {
                self.startNetworkMonitoring()
            }
        case .reachable(.cellular):
          self.dismissOfflineAlert()
        case .reachable(.ethernetOrWiFi):
          self.dismissOfflineAlert()
        case .unknown:
          print("Unknown network state")
        }
      }
    }

    func showErrorResponse(_ statusCode: Int?, callback: (() -> Void)?) {
        switch statusCode {
        case 400:
            showErroWithMessage(title: "Bad Request",
                                message: "We could not process that action",
                                callback: callback)
        case 403:
            showErroWithMessage(title: "Forbidden",
                                message: "You exceeded the rate limit",
                                callback: callback)
        case 404:
            showErroWithMessage(title: "Not Found",
                                message: "The requested resource could not be found",
                                callback: callback)
        case 500:
            showErroWithMessage(title: "Internal Server Error",
                                message: "We had a problem with our server. Please try again later",
                                callback: callback)
        case 503:
            showErroWithMessage(title: "Service Unavailable",
                                message: "We are temporarily offline for maintenance. Please try again later",
                                callback: callback)
        default:
            return
        }
    }

    private func showErroWithMessage(title: String, message: String, callback: (() -> Void)?) {
        alertView.showAlert(title, message, onAction: callback)
    }

    func showOfflineAlert(callback: (() -> Void)?) {
        alertView.showAlert("No Network", "Please connect to network and try again", onAction: callback)
    }

    func dismissOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
