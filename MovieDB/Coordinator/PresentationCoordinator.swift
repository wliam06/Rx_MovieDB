//
//  PresentationCoordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit

protocol PresentationCoordinator {
    associatedtype RootViewController: UIViewController
}

protocol Presentable { 
    var rootViewController: UIViewController { get }
}

extension Presentable {
    var root: UIViewController { return rootViewController }
}

//extension Presentable {
//    var root: UIViewController { return rootViewController }
//
//    /**
//     Starts a child coordinator and presents its `rootViewController` modally. This method also retains the `childCoordinator` in memory, which needs to be released upon dismissal.
//
//     - Parameters:
//        - childCoordinator: The coordinator to present and retain.
//        - animated: Specify `true` to animate the transition or `false` if you do not want the transition to be animated.
//     */
//
//    func presentCoordinator(_ childCoordinator: PresentationCoordinator, animated: Bool) {
//        self.addChild(childCoordinator)
//        childCoordinator.start()
//        rootViewController.present(childCoordinator.controller, animated: animated)
//    }
//
//    /**
//     Dismisses a child coordinator's `rootViewController` which was presented modally, and releases the coordinator from memory.
//
//     - Parameters:
//        - childCoordinator: The coordinator to dismiss and release.
//        - animated: Specify `true` to animate the transition or `false` if you do not want the transition to be animated.
//        - completion: The block to execute after the view controller is dismissed.
//     */
//
//    func dismissCoordinator(_ childCoordinator: PresentationCoordinator, animated: Bool, completion: (() -> Void)? = nil) {
//        childCoordinator.controller.dismiss(animated: animated, completion: completion)
//        self.removeChild(childCoordinator)
//    }
//}
