//
//  MovieDetail.swift
//  MovieNight
//
//  Created by Dushyant Singh on 11/5/22.
//

import Foundation

struct MovieDetail: Codable {
    let imdbID: String?
    let title: String?
    let poster: String?
    let year: String?
    let rated: String?
    let runtime: String?
    let genre: String?
    let writer: String?
    let actors: String?
    let director: String?
    let plot: String?
    let metascore: String?
    let imdbRating: String?
    let language: String?
    let country: String?
    let awards: String?

    private enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case poster = "Poster"
        case year = "Year"
        case rated = "Rated"
        case runtime = "Runtime"
        case genre = "Genre"
        case writer = "Writer"
        case actors = "Actors"
        case director = "Director"
        case plot = "Plot"
        case metascore = "Metascore"
        case imdbRating
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
    }
}
