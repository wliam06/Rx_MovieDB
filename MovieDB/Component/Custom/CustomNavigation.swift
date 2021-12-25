//
//  CustomNavigation.swift
//  MovieDB
//
//  Created by William on 25/12/21.
//

import UIKit

class CustomNavigation: UINavigationController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.backgroundColor = .red
//        setNavigationBarHidden(true, animated: animated)
    }
}
