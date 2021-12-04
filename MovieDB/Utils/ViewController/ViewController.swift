//
//  ViewController.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import UIKit
import NSObject_Rx

protocol ViewControllerBinder: AnyObject {
    func setConstraint()
    func loadUI()
    func bindViewModel()
}

class ViewController: UIViewController, HasDisposeBag {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        setConstraint()
        bindViewModel()
    }

    // Override method
    func loadUI() {}
    func setConstraint() {}
    func bindViewModel() {}
}
