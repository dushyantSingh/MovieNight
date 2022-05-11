//
//  MovieHomeViewControllerSpec.swift
//  MovieNight
//
//  Created by Dushyant Singh on 11/5/22.
//

import Foundation
import Quick
import RxSwift
import Nimble

@testable import MovieNight

class MovieHomeViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieHomeViewController Test") {
            var subject: MovieHomeViewController!
            var service: MockMovieService!
            beforeEach {
                service = MockMovieService()
                let viewModel = MovieHomeViewModel(service: service)
                subject = UIViewController.make(viewController: MovieHomeViewController.self)
                subject.viewModel = viewModel
                _ = subject.view
            }
            context("when view loads") {
                it("should not show movies") {
                    expect(subject.movieListView.isHidden) == true
                }
                it("should not search any movies") {
                    expect(subject.collectionView.numberOfItems(inSection: 0)) == 0
                }
                it("should display search view") {
                    expect(subject.searchView.isHidden) == false
                }
            }
            context("when some movie name is searched") {
                it("should make a service call to retrieve movie list") {
                    subject.movieSearchTextField.text = "Marvel"
                    subject.searchButton.sendActions(for: .touchUpInside)
                    expect(service.retrieveMovieListCalledWith) == "Marvel"
                }
                it("should display retrieved movie list") {
                    subject.movieSearchTextField.text = "Marvel"
                    subject.searchButton.sendActions(for: .touchUpInside)
                    let response = SearchResponse(search: Factory.MovieList)
                    service.mockObservable.onNext(NetworkingEvent.success(response))
                    expect(subject.collectionView.numberOfItems(inSection: 0)) == 2
                }
            }
        }
    }
}
