//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxFramework
import Networking
import MovieKit

class MovieListViewController: ParentViewController, Bindable {
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

        viewModel.didLoad()
    }

    override func setupConstraint() {
        super.setupConstraint()
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        indicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(30)
        }
    }

    // Binding ViewModel
    func bindViewModel() {
        rx.bind(
            viewModel.$viewState ~> { [weak self] in
                switch $0 {
                case .start, .loading:
                    self?.indicator.startAnimating()
                default:
                    self?.indicator.stopAnimating()
                }
            }
        )

        let nowPlaying = movieSection(
            source: viewModel.$nowPlaying
        ) { (data, cell: NowPlayingMovieCell) in
            cell.bind(
                data: data,
                action: self.viewModel.didSelectMovie(movie:)
            )
        }

        let popular = movieSection(
            source: viewModel.$popular
        ) { (data, cell: SectionMovieCell) in
            cell.bind(
                sectionTitle: "Popular Movie",
                data: data,
                action: self.viewModel.didSelectMovie(movie:)
            )
        }

        let upcoming = movieSection(
            source: viewModel.$upcoming
        ) { (data, cell: SectionMovieCell) in
            cell.bind(
                sectionTitle: "Upcoming Movie",
                data: data,
                action: self.viewModel.didSelectMovie(movie:)
            )
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
        configureCell: @escaping(
            _ data: [MovieResponse],
            _ cell: Cell
        ) -> ()
    ) -> Observable<TableSectionViewModelProtocol> {
        source.map { data in
            TableSectionViewModel.cells(cellCount: 1) { (cell: Cell) in
                configureCell(data, cell)
            }
        }
    }
}
