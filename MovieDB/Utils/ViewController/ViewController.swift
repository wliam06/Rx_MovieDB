//
//  ViewController.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import UIKit
import RxSwift

protocol ViewControllerBinder: AnyObject {
    func setConstraint()
    func loadUI()

    var disposeBag: DisposeBag { get }
}

class ViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Override method
    func loadUI() {}
    func setConstraint() {}

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        setConstraint()
    }

    func bindViewModel() {}
}
