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

private enum MovieListType {
    case nowPlaying
    case popuplar
    case upcoming
}

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

    var viewModel: MovieListViewModel!

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

        viewModel.stateMachine.transition(.viewDidLoad)
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

        let cellSections = Observable.combineLatest(
            viewModel.stateMachine.$currentState.map ({
                $0.nowPlaying
            }),
            viewModel.stateMachine.$currentState.map ({
                $0.popular
            }),
            viewModel.stateMachine.$currentState.map ({
                $0.upcoming
            })
        ) { [weak self] (nowPlaying, popular, upcoming) -> [TableSectionViewModelProtocol] in
            guard let self = self else {
                // Return skeleton cell
                return [TableSectionViewModel.cells(cellCount: 8) { (_: UITableViewCell) in}]
            }
            let nowPlayingSections = self.movieSection(
                source: nowPlaying
            ) { (data, cell: NowPlayingMovieCell) in
                cell.bind(
                    data: nowPlaying,
                    action: self.viewModel.navigateToDetail(movie:)
                )
            }

            let popularSections = self.movieSection(
                source: popular
            ) { (data, cell: SectionMovieCell) in
                cell.bind(
                    sectionTitle: "Popular Movie",
                    data: data,
                    action: self.viewModel.navigateToDetail(movie:)
                )
            }

            let upcomingSections = self.movieSection(
                source: upcoming
            ) { (data, cell: SectionMovieCell) in
                cell.bind(
                    sectionTitle: "Upcoming Movie",
                    data: data,
                    action: self.viewModel.navigateToDetail(movie:)
                )
            }

            return [nowPlayingSections, popularSections, upcomingSections]
        }

        tableView.rx.items(
            sections: cellSections
        ).disposed(by: disposeBag)
    }

    private func movieSection<Cell: UITableViewCell>(
        source: [MovieResponse],
        configureCell: @escaping(
            _ data: [MovieResponse],
            _ cell: Cell
        ) -> ()
    ) -> TableSectionViewModelProtocol {
        TableSectionViewModel.cells(cellCount: 1) { (cell: Cell) in
            configureCell(source, cell)
        }
    }
}
