//
//  Config.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation

public struct Config {
    struct API {
        enum STAGING {
            static let HOST = "http://54.184.111.107:3000/"
        }
        enum LIVE {
            static let HOST = "LIVE"
        }
    }
    
    struct NOTIFICATION {
        enum ONESIGNAL {
            static let KEY = "ONESIGNAL"
        }
    }
    
}
