//
//  NetworkManager.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation
import Moya

enum APIEnvironment {
    case staging
    case live
    
    var baseURL: String {
        switch NetworkManager.environment {
        case .staging:
            return Config.API.STAGING.HOST
        case .live:
            return Config.API.LIVE.HOST
        }
    }
}

struct NetworkManager {
    static let environment: APIEnvironment = .staging
}

