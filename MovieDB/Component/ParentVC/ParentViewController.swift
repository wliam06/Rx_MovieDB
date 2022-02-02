//
//  ParentViewController.swift
//  MovieDB
//
//  Created by William on 02/02/22.
//

import UIKit

class ParentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .colorMode(
            light: .white,
            dark: .black
        )

        loadUI()
    }

    private func loadUI() {
        setupUI()
        setupConstraint()
    }
    
    func setupUI() {}
    func setupConstraint() {}
}
