//
//  NowPlayingViewController.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

class NowPlayingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .red
    }    
}
