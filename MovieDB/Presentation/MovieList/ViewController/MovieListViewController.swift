//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class MovieListViewController: ParentViewController, Bindable, HasDisposeBag {
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.tableHeaderView = UITableView.removeTableHeaderView
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

    var viewModel: ImpMovieListViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(
            true,
            animated: animated
        )
    }

    // MARK: - Override method from ViewDidLoad
    override func setupUI() {
        super.setupUI()

        self.view.addSubviews(indicator, tableView)
        setupConstraint()

        tableView.registerCells(
            NowPlayingMovieCell.self,
            SectionMovieCell.self
        )
    }

    override func setupConstraint() {
        super.setupConstraint()
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
    }

    // Binding ViewModel
    func bindViewModel() {
        rx.bind(
            viewModel.$isLoading ~> indicator.rx.isAnimating
        )

        let nowPlaying = movieSection(
            source: viewModel.$nowPlaying,
            loadingSource: viewModel.$isNowPlayingLoading
        ) { (data, cell: NowPlayingMovieCell) in
            cell.bind(data: data)
            cell.movieDidTap = { [weak self] in
                self?.viewModel.didSelectMovie(movie: $0)
            }
        }

        let popular = movieSection(
            source: viewModel.$popular,
            loadingSource: viewModel.$isPopularLoading
        ) { (data, cell: SectionMovieCell) in
            cell.bind(sectionTitle: "Popular Movie", data: data)
            cell.movieDidTap = { [weak self] in
                self?.viewModel.didSelectMovie(movie: $0)
            }
        }

        let upcoming = movieSection(
            source: viewModel.$upcoming,
            loadingSource: viewModel.$isUpcomingLoading
        ) { (data, cell: SectionMovieCell) in
            cell.bind(sectionTitle: "Upcoming Movie", data: data)
            cell.movieDidTap = { [weak self] in
                self?.viewModel.didSelectMovie(movie: $0)
            }
        }

        _ = tableView.rx.items(
            sections: Observable.combineLatest([
                nowPlaying,
                popular,
                upcoming
            ])
        )
    }

    private func movieSection<Cell: UITableViewCell>(
        source: Observable<[MovieResponse]>,
        loadingSource: Observable<Bool>,
        configureCell: @escaping(
            _ data: [MovieResponse],
            _ cell: Cell
        ) -> ()
    ) -> Observable<TableSectionViewModelProtocol> {
        Observable.combineLatest(source, loadingSource) { (data, isLoading) in
            TableSectionViewModel.cells(cellCount: 1) { (cell: Cell) in
                configureCell(data, cell)
            }
        }
    }
}
