//
//  ParentViewController.swift
//  MovieDB
//
//  Created by William on 02/02/22.
//

import UIKit
import NSObject_Rx
import MovieKit

class ParentViewController: UIViewController, HasDisposeBag {
    enum ViewState {
        case loading
        case loaded
        case idle
        case error(Error)

        mutating func isLoading() {
            switch self {
            case .loading:
                print("IS LOADING")
            default:
                self = .loading
            }
        }
    }

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

extension ParentViewController {
    func render(state: ViewState) {
        switch state {
        case .loading:
            print("view state loading")
        case .loaded:
            print("view state loaded")
        case .error(let error):
            print("view state error")
        case .idle:
            print("view state idle")
        }
    }
}
