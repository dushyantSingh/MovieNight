//
//  MovieTarget.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import Moya
import RxSwift

enum MovieTarget {
    case getMovies(searchText: String)
}

extension MovieTarget: TargetType {

    var baseURL: URL {
        switch self {
        case .getMovies:
            return Enviornment.manager.baseURL
        }
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return Method.get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getMovies(let searchText):
            return .requestParameters(parameters: ["apikey": Enviornment.manager.apiKey,
                                                   "s": searchText,
                                                   "type": "movie"],
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}


class Enviornment {
    static let manager = Enviornment()
    var baseURL: URL {
        return URL(string: "https://www.omdbapi.com/")!
    }

    let apiKey = "b9bd48a6"
}
