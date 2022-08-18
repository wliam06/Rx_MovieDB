//
//  AppDelegate.swift
//  MovieDB
//
//  Created by William on 13/08/21.
//

import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window)
        // notification
        let notification = launchOptions?[.remoteNotification] as? [String: Any]
        let deeplink = DeeplinkOption.build(with: notification)
        coordinator.start(with: deeplink)
        self.window?.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        let dict = userInfo as? [String: Any]
        let deeplink = DeeplinkOption.build(with: dict)
        coordinator.start(with: deeplink)
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        let deeplink = DeeplinkOption.build(with: userActivity)
        coordinator.start(with: deeplink)
        return true
    }
}
