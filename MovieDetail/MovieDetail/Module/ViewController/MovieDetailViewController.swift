//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by William on 21/12/21.
//

import UIKit
import Core
import RxFramework
import MovieKit

class MovieDetailViewController: ParentViewController, Bindable {
    private lazy var headerView = MovieDetailHeaderView()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.contentInsetAdjustmentBehavior = .never
        table.sectionHeaderHeight = 320
        table.estimatedSectionHeaderHeight = .leastNonzeroMagnitude
        return table
    }()

    private lazy var indicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activity.style = .large
        } else {
            // Fallback on earlier versions
            activity.style = .whiteLarge
        }
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    var viewModel: MovieDetailViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(
            false,
            animated: animated
        )
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel.didDisappear()

        self.navigationController?.setNavigationBarHidden(
            true,
            animated: animated
        )
    }

    override func setupUI() {
        super.setupUI()
        self.viewModel.stateMachine.transition(.viewDidLoad)

        self.view.addSubviews(indicator, tableView)

        tableView.registerCells(MovieDetailCell.self)
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    override func setupConstraint() {
        super.setupConstraint()

        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        indicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
        }
    }

    func bindViewModel() {
        viewModel
            .stateMachine
            .$currentState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] in
                switch $0 {
                case .isLoading:
                    self?.indicator.startAnimating()
                case .error:
                    // error
                    print("Error")
                default:
                    self?.indicator.stopAnimating()
                }
            }).disposed(by: disposeBag)

        let movieSection = Observable.combineLatest(
            viewModel.stateMachine.$currentState.map ({
                $0 == .isLoading
            }),
            viewModel.stateMachine.$currentState.map ({
                $0.movieDetail
            })
        ) { [weak self] (loading, movie) -> TableSectionViewModelProtocol in
            guard let self = self else {
                // Return skeleton cell
                return TableSectionViewModel.cells(cellCount: 8) { (_: UITableViewCell) in}
            }
            
            return TableSectionViewModel(entries: movie) { [weak self] (_, data, cell: MovieDetailCell) in
                cell.bind(movie: data)
                self?.headerView.bind(data.movieImg)
            }.asProtocol

        }

        tableView.rx.items(
            sections: Observable.combineLatest([movieSection])
        ).disposed(by: disposeBag)
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return headerView
    }
}
