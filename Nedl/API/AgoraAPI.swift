//
//  AgoraAPI.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-27.
//

import Foundation
import Moya
import Alamofire

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 100 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 100 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

//let provider = MoyaProvider<OpenApi>(session: DefaultAlamofireSession.shared, plugins: [authPlugin])

enum AgoraAPI {
    case getRTCToken(streamUrl: String)
    case startStream(streamUrl: String)
    case endStream(streamUrl: String)
    
    case getCaller(streamUrl: String)
    case addCaller(streamUrl: String, callerId: Int, status: String)
    case endCaller(streamUrl: String, callerId: Int, status: String)
    
}

extension AgoraAPI: TargetType {
    
    
    var environment: APIEnvironment {
        NetworkManager.environment
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environment.baseURL) else {fatalError("base url not configured")}
        return url
    }
    
    public var path: String {
        switch self {
        case .getRTCToken(let streamUrl):
            return "agora/streams/\(streamUrl)/rtc-token/"
        case .startStream(let streamUrl):
            return "agora/streams/\(streamUrl)/"
        case .endStream(let streamUrl):
            return "agora/streams/\(streamUrl)/"
        case .getCaller(let streamUrl):
            return "agora/streams/\(streamUrl)/callers/"
        case .addCaller(let streamUrl, let callerId, _):
            return "agora/streams/\(streamUrl)/callers/\(callerId)/"
        case .endCaller(let streamUrl, let callerId, _):
            return "agora/streams/\(streamUrl)/callers/\(callerId)/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getRTCToken(_):
            return .get
        case .startStream(_):
            return .post
        case .endStream(_):
            return .delete
        case .getCaller(_):
            return .get
        case .addCaller(_, _, _):
            return .put
        case .endCaller(_, _, _):
            return .delete
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getRTCToken(_):
            return .requestPlain
        case .startStream(_):
            return .requestPlain
        case .endStream(_):
            return .requestPlain
        case .getCaller(_):
            return .requestPlain
        case .addCaller(_, _, status: let status):
            return .requestParameters(
                parameters: [
                    "status": status
                ],
                encoding: JSONEncoding.default)
        case .endCaller(_, _, status: let status):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        
        let token = DataStore.shared.getAccessToken() ?? ""
        
        let params = [
            "Authorization": "Bearer \(token)",
            "backapp": "123",
            "accept-timezone" : TimeZone.current.identifier
        ]
        
        return params
//        switch self {
//        case .getRTCToken(_):
//            return params
//        case .startStream(_):
//            return params
//        case .endStream(_):
//            return params
//        case .getCaller(_):
//            return params
//        case .addCaller(streamUrl: <#T##String#>, callerId: <#T##Int#>, status: <#T##String#>)
//        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
