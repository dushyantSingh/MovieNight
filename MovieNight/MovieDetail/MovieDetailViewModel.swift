//
//  MovieDetailViewModel.swift
//  MovieNight
//
//  Created by Dushyant Singh on 10/5/22.
//

import Foundation
import RxSwift

struct MovieDetailViewModel {
    enum Event {
        case loading
        case error(String)
        case displayMovieDetail(MovieDetail)
    }
    
    let selectedMovie: Movie
    let events = PublishSubject<Event>()

    private let disposeBag = DisposeBag()
    private let service: MovieServiceType

    init(movie: Movie,
         service: MovieServiceType) {
        selectedMovie = movie
        self.service = service
    }

    func fetchMovieDetails() {
        if let id = selectedMovie.imdbID {
            events.onNext(.loading)
            service.retrieveMovieDetail(movieId: id).asObservable()
                .map { details in
                    switch details {
                    case .success(let response):
                        if let movieResult = response as? MovieDetail {
                            return .displayMovieDetail(movieResult)
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
}
