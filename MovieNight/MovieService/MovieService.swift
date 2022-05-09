//
//  MovieService.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import Moya
import RxSwift

protocol MovieServiceType {
    func retrieveMovieList(text: String) -> Observable<NetworkingEvent>
}

class MovieService: MovieServiceType {
    let provider: MoyaProvider<MovieTarget>

    private let disposeBag = DisposeBag()

    init(provider: MoyaProvider<MovieTarget>) {
        self.provider = provider
    }

    func retrieveMovieList(text: String) -> Observable<NetworkingEvent> {
        return self.provider.rx
            .request(.getMovies(searchText: text))
            .asObservable()
            .map { response in
                if response.is2xx() {
                    let decoder = JSONDecoder()
                    do {
                       let movieList = try decoder.decode(SearchResponse.self, from: response.data)
                        return .success(movieList)
                    } catch {
                        print(error.localizedDescription)
                        return .failed
                    }
                } else {
                    return .failed
                }
            }.startWith(.waiting)
    }
}

extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            let key = keys.last!
            guard key.intValue == nil else {
                return key
            }

            let codingKeyType = type(of: key)
            let newStringValue = key.stringValue.firstCharLowercased()

            return codingKeyType.init(stringValue: newStringValue)!
        }
    }
}

private extension String {
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}
