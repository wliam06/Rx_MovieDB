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
//        let table = UITableView(frame: .zero, style: .grouped)
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
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

        tableView.registerCells(NowPlayingMovieCell.self)
    }

    override func setupConstraint() {
        super.setupConstraint()

        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
            viewModel.activityLoading ~> indicator.rx.isAnimating
        )

        let nowPlaying = movieSection(
            source: viewModel.nowPlayingResult,
            loadingSource: viewModel.nowPlayingLoaded
        ) { (data, cell: NowPlayingMovieCell) in
                cell.bind(data: data)
            }

        tableView.rx.items(
            sections: Observable.combineLatest([
                nowPlaying
            ])
        )
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        viewModel.popularResult.bind(
//            to: upcomingView.collectionView.rx.items(cellType: SectionMovieCell.self)
//        ) { index, data, cell in
//            cell.configure(poster: data.posterPath)
//        }.disposed(by: disposeBag)
//
//        upcomingView.collectionView.rx.itemSelected.subscribe(onNext: { [weak self] _ in
//            self?.viewModel.didSelectMovie()
//        }).disposed(by: disposeBag)
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

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return UITableView.automaticDimension
        }
    }
}
