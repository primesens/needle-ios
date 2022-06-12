//
//  RegisterErrorResult.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation

// MARK: - RegisterErrorResult

struct RegErrorResult: Codable {
    let errors: Errors
}

struct Errors: Codable {
    let phone: Phone
}

struct Phone: Codable {
    let location: String?
    let param: String?
    let value: String?
    let msg: String?
}
