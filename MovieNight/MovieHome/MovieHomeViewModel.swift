//
//  MovieHomeViewModel.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import RxSwift

struct MovieHomeViewModel {
    private let service: MovieServiceType
    var disposeBag = DisposeBag()

    init(service: MovieServiceType = ServiceFactory.movieService) {
        self.service = service
    }

    func searchMovies(searchText: String) {
        service.retrieveMovieList(text: searchText)
            .subscribe(onNext: { searchResult in
                switch searchResult {
                case .success(let response):
                    print(response)
                case .failed:
                    print("Failed")
                case .waiting:
                    print("Waiting")
                }
            })
            .disposed(by: disposeBag)
    }
}
