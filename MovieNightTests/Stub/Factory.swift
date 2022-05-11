//
//  Factory.swift
//  MovieNightTests
//
//  Created by Dushyant Singh on 11/5/22.
//

import Foundation
@testable import MovieNight

struct Factory {
    static let MovieList = [Movie(imdbID: "123",
                                  title: "Captain Marvel",
                                  poster: "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg",
                                  year: "2019"),
                            Movie(imdbID: "111",
                                  title: "Captain America",
                                  poster: "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg",
                                  year: "2010")]

    static let MovieDetailCaptain = MovieDetail(imdbID: "123",
                                                title: "Captain Marvel",
                                                poster: "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg",
                                                year: "2019",
                                                rated: "PG",
                                                runtime: "120 mins",
                                                genre: "Action",
                                                writer: "Some writer",
                                                actors: "Some actors",
                                                director: "Some directors",
                                                plot: "Plot twist is not available",
                                                metascore: "82",
                                                imdbRating: "6.5",
                                                language: "English",
                                                country: "USA",
                                                awards: "1 award")
}
