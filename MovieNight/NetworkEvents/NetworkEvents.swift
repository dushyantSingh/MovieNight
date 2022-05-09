//
//  NetworkEvents.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import Moya

enum NetworkingEvent {
    case waiting
    case success(Any)
    case failed
}

extension NetworkingEvent: Equatable {
    static func == (lhs: NetworkingEvent, rhs: NetworkingEvent) -> Bool {
        switch (lhs, rhs) {
        case (.waiting, .waiting):
            return true
        case (.failed, .failed):
            return true
        case (.success, .success):
            return true
        default:
            return false
        }
    }
}

extension Response {
    public func is2xx() -> Bool {
        if (self.statusCode >= 200) && (self.statusCode < 300) { return true }

        return false
    }
}
