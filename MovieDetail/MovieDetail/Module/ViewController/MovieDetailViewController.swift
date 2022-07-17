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

        viewModel.didDisappear()

        self.navigationController?.setNavigationBarHidden(
            true,
            animated: animated
        )
    }

    override func setupUI() {
        super.setupUI()

        viewModel.didLoad()
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
            cell.bind(movie: item)
            self?.headerView.bind(item.movieImg)
            
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
