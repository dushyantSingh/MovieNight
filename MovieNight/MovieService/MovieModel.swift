//
//  MovieModel.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation

struct Movie: Codable {
    let imdbID: String?
    let title: String?
    let poster: String?
    let year: String?

    private enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case poster = "Poster"
        case year = "Year"
    }
}

struct SearchResponse: Codable {
    let search: [Movie]?
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
