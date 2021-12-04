//
//  ImpHomeViewModel.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import Foundation

final class HomeViewModel {
    @RxPublished var movies = [MovieResponse]()
    @RxPublished private(set) var isLoading = false
    @RxPublished private(set) var onShowAlert: (((() -> Void)?) -> Void)?

    private let usecase: HomeUsecase

    init(usecase: HomeUsecase) {
        self.usecase = usecase

        initialLoad()
    }

    private func initialLoad() {
        isLoading = true

        usecase.fetchNowPlaying(page: 1) { [weak self] result in
            switch result {
            case .success(let response):
                self?.isLoading = false
                self?.movies = response.results
            case .failure(let error):
                print("ERROR VIEW MODEL", error.localizedDescription)
                self?.onShowAlert?(self?.initialLoad)
            }
        }
    }
}
