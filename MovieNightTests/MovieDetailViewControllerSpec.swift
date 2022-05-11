//
//  MovieDetailViewControllerSpec.swift
//  MovieNightTests
//
//  Created by Dushyant Singh on 11/5/22.
//

import Foundation
import Quick
import Nimble

@testable import MovieNight

class MovieDetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailViewController Test") {
            var subject: MovieDetailViewController!
            var service: MockMovieService!
            beforeEach {
                service = MockMovieService()
                let viewModel = MovieDetailViewModel(movie: Factory.MovieList[0],
                                                     service: service)
                subject = UIViewController.make(viewController: MovieDetailViewController.self)
                subject.viewModel = viewModel
                _ = subject.view
            }
            context("when view loads") {
                it("should show movie title") {
                    expect(subject.movieTitle.text) == "Captain Marvel"
                }
                it("should show movie image") {
                    expect(subject.posterImageView.image).notTo(beNil())
                }
                it("should not display details") {
                    expect(subject.detailStackView.isHidden) == true
                }
                it("should not display meta details") {
                    expect(subject.metaDataView.isHidden) == true
                }
                it("should not display plot description") {
                    expect(subject.plotDescription.text).to(beEmpty())
                }
            }
            context("when movie details are fetched") {
                beforeEach {
                    subject.viewModel.fetchMovieDetails()
                }
                it("should make a service call to retrieve movie details") {
                    expect(service.retrieveMovieDetailCalledWith) == "123"
                }
                it("should display retrieved movie details") {
                    service.mockObservable.onNext(NetworkingEvent.success(Factory.MovieDetailCaptain))
                    expect(subject.plotDescription.text) == "Plot twist is not available"
                    expect(subject.detailStackView.isHidden) == false
                    expect(subject.metaDataView.isHidden) == false
                }
            }
        }
    }
}
