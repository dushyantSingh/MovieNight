//
//  MovieModel.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation

struct Movie: Codable {
    var imdbID: String?
    var title: String?
    var poster: String?
    var year: String?

    private enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case poster = "Poster"
        case year = "Year"
    }
}

struct SearchResponse: Codable {
    var search: [Movie]?
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
