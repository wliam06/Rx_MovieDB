//
//  ImpHomeViewModel.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import Foundation

final class ImpHomeViewModel: HomeViewModel {
    private let usecase: HomeUsecase

    init(usecase: HomeUsecase) {
        self.usecase = usecase

        initialLoad()
    }

    private func initialLoad() {
        usecase.fetchNowPlaying(page: 1) { [weak self] result in
            switch result {
            case .success(let response):
                print("SUCCESS", response)
            case .failure(let error):
                print("ERROR VIEW MODEL", error.localizedDescription)
            }
        }
    }
}
