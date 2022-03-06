//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by William on 21/12/21.
//

import UIKit
import RxSwift
import NSObject_Rx

class MovieDetailViewController: ParentViewController, Bindable, HasDisposeBag {
    private lazy var headerView = MovieDetailHeaderView()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.contentInsetAdjustmentBehavior = .never
        return table
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

        self.navigationController?.setNavigationBarHidden(
            true,
            animated: animated
        )
    }

    override func setupUI() {
        super.setupUI()

        self.view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.registerCells(MovieDetailCell.self)
        tableView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
    }

    func bindViewModel() {
        viewModel.$movie.bind(
            to: tableView.rx.items(cellType: MovieDetailCell.self)
        ) { [weak self] _, item, cell in
            var data = item
            cell.bind(movie: item)
            self?.headerView.bind(data.getMovieImg())
            
        }.disposed(by: disposeBag)
    }
}
extension MovieDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return headerView
    }

    func tableView(
        _ tableView: UITableView,
        estimatedHeightForHeaderInSection section: Int
    ) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 320
    }
}
