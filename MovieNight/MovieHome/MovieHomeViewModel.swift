//
//  MovieHomeViewModel.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieHomeViewModel {
    enum Event {
        case loading
        case error(String)
        case displayMovies([Movie])
    }

    private let service: MovieServiceType
    let getMovies = PublishSubject<String>()
    let events = PublishSubject<Event>()
    var disposeBag = DisposeBag()

    init(service: MovieServiceType = ServiceFactory.movieService) {
        self.service = service
        setupMovieSearch()
    }
}

private extension MovieHomeViewModel {
    func setupMovieSearch() {
        getMovies.asObservable()
            .flatMap { service.retrieveMovieList(text: $0) }
            .map { searchResult in
                switch searchResult {
                case .success(let response):
                    print(response)
                    if let movieResult = response as? SearchResponse,
                       let movies = movieResult.search {
                        return .displayMovies(movies)
                    } else {
                        return .error("No movies found")
                    }
                case .failed:
                    print("Failed")
                    return .error("Movie fetch failed")
                case .waiting:
                    return .loading
                }
            }
            .bind(to: events)
            .disposed(by: disposeBag)
    }
}
