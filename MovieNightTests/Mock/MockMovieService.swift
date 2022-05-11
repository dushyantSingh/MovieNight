//
//  MockMovieService.swift
//  MovieNightTests
//
//  Created by Dushyant Singh on 11/5/22.
//

import Foundation
import RxSwift

@testable import MovieNight

class MockMovieService: MovieServiceType {
    var retrieveMovieListCalledWith: String?
    let mockObservable = PublishSubject<NetworkingEvent>()
    func retrieveMovieList(text: String) -> Observable<NetworkingEvent> {
        retrieveMovieListCalledWith = text
        return mockObservable
    }

    var retrieveMovieDetailCalledWith: String?
    func retrieveMovieDetail(movieId: String) -> Observable<NetworkingEvent> {
        retrieveMovieDetailCalledWith = movieId
        return mockObservable
    }
}
