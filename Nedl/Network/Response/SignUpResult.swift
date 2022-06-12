//
//  SignUpResult.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation
import SwiftUI
import RealmSwift

class SignUpResult:Object, Codable {
    
    @objc dynamic var token: String?
    var user: User?
    
    init(token: String?, user: User?) {
     
        self.token = token
        self.user = user
    }
    

    
    required override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
}

