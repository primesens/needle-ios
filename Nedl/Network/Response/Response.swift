//
//  Response.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation

struct NedlGeneric: Codable {
    let success: Bool
    let message: String
}

struct NedlMessage: Codable {
    let message: String
}
struct NedlGenericSuccess: Codable {
    let message: String
    let code: String
}

struct NedlLoginSuccess: Codable {
    let message: String
    let code: String
    let verificationStatus: String
}
struct NedlResponse<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: T
}

struct NedlResults<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: [T]
}

struct NedlErrors<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: [T]
}

struct NedlError: Codable {
    let success: Bool
    let message: String
}

struct NedlResponseNew<T: Codable>: Codable {
    let data: T
}

struct NedlVerifyTokenResponse<T: Codable>: Codable {
    let response: T
}


