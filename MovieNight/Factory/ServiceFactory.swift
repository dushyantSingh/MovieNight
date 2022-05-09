//
//  ServiceFactory.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import Moya

struct ServiceFactory {
    static let movieService = MovieService(provider: MoyaProvider<MovieTarget>())
}
