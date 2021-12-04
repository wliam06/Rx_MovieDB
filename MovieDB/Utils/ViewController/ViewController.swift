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
    func bindViewModel()

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
