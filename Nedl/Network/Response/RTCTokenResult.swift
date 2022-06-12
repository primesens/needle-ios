//
//  RTCTokenResult.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-27.
//

import Foundation

class RTCTokenResult: Codable {
    let rtcToken: String
    
    enum CodingKeys: String, CodingKey {
        case rtcToken = "rtcToken"
    }
    
    init(rtcToken: String) {
        self.rtcToken = rtcToken
    }
}
