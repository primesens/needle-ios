//
//  AuthAPI.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation
import Moya

enum AuthAPI {
    case login(phone: String)
    case sendCode(phone: String, userType: String)
    case verifyCode(phone: String, code: String, hash: String)
    case streamUrl(streamUrl: String)
    case signUp(phoneNumber: String)
    case getProfile
}

extension AuthAPI: TargetType {
    
    var environment: APIEnvironment {
        NetworkManager.environment
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environment.baseURL) else {fatalError("base url not configured")}
        return url
    }
    
    public var path: String {
        switch self {
        case .login(_):
            return "user/login/"
        case .sendCode(_, _):
            return "user/register/"
        case .verifyCode(_, _, _):
            return "user/verify-otp/"
        case .streamUrl(_):
            return "user/streamurl/"
        case .signUp(_):
            return "user/register/"
        case .getProfile:
            return "/user/account"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login(_), .sendCode(_, _), .verifyCode(_, _, _), .streamUrl, .signUp(_):
            return .post
        case .getProfile:
            return .get
        }
        
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getProfile:
            return .requestPlain
        case .login(let phone):
            return .requestParameters(
                parameters: [
                    "phone": phone,
//                    "notificationServiceDetails": [
//                        "identifier": DataStore.shared.getPlayerId() ?? "",
//                        "deviceType": 0
//                    ]
                ],
                encoding: JSONEncoding.default)
        case .sendCode(let phone, let userType):
            return .requestParameters(
                parameters: [
                    "phone": phone,
                    "userType": userType
//                    "notificationServiceDetails": [
//                        "identifier": DataStore.shared.getPlayerId() ?? "",
//                        "deviceType": 0
//                    ]
                ],
                encoding: JSONEncoding.default)
            
        case .verifyCode(let phone, let code, let hash):
            return .requestParameters(
                parameters: [
                    "phone": phone,
                    "code": code,
                    "hash": hash
//                    "notificationServiceDetails": [
//                        "identifier": DataStore.shared.getPlayerId() ?? "",
//                        "deviceType": 0
//                    ]
                ],
                encoding: JSONEncoding.default)
            
        case .streamUrl(let streamUrl):
            return .requestParameters(
                parameters: [
                    "streamUrl": streamUrl
//                    "notificationServiceDetails": [
//                        "identifier": DataStore.shared.getPlayerId() ?? "",
//                        "deviceType": 0
//                    ]
                ],
                encoding: JSONEncoding.default)
            
            
        case .signUp(let phoneNumber):
            return .requestParameters(
                parameters: [
                    "phoneNumber": phoneNumber
                ],
                encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        let token = DataStore.shared.getAccessToken() ?? ""
        
        var params = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "backapp": "123",
                      "accept-timezone" : TimeZone.current.identifier
        ]
        switch self {
        case .login(_), .sendCode(_, _), .verifyCode(_, _, _), .signUp(_), .getProfile:
            return params
    
            
        case .streamUrl:
            params["Authorization"] = "Bearer \(token)"
            return params
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
