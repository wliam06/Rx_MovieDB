//
//  NetworkReachability.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Alamofire

final class NetworkReachability {
    
    static let shared = NetworkReachability()
    let reachabilityManager = NetworkReachabilityManager()
//    private var alertView = AlertViewController.shared

    func startNetworkMonitoring() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
    //            self.showOfflineAlert {
    //                self.startNetworkMonitoring()
    //            }
                print("Not reachable")
            case .reachable(.cellular), .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            default:
                self.dismissOfflineAlert()
            }
        })

    }

    func showErrorResponse(_ statusCode: NetworkError?, callback: (() -> Void)?) {
        switch statusCode {
        case .BadRequest:
            print("bad request")
//            showErroWithMessage(title: "Bad Request",
//                                message: "We could not process that action",
//                                callback: callback)
        case .Forbidden:
            print("Forbidden")
//            showErroWithMessage(title: "Forbidden",
//                                message: "You exceeded the rate limit",
//                                callback: callback)
        case .NotFound:
            print("NotFound")
//            showErroWithMessage(title: "Not Found",
//                                message: "The requested resource could not be found",
//                                callback: callback)
        case .InternalServerError:
            print("Internal ServerError")
//            showErroWithMessage(title: "Internal Server Error",
//                                message: "We had a problem with our server. Please try again later",
//                                callback: callback)
        case .ServiceUnavailable:
            print("service unavailable")
//            showErroWithMessage(title: "Service Unavailable",
//                                message: "We are temporarily offline for maintenance. Please try again later",
//                                callback: callback)
        default:
            return
        }
    }

//    private func showErroWithMessage(title: String, message: String, callback: (() -> Void)?) {
//        alertView.showAlert(title, message, onAction: callback)
//    }
//
//    func showOfflineAlert(callback: (() -> Void)?) {
//        alertView.showAlert("No Network", "Please connect to network and try again", onAction: callback)
//    }

    func dismissOfflineAlert() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
