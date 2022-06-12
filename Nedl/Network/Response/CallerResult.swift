//
//  CallerResult.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-06-10.
//

import Foundation

class CallerResult: Codable {
    let callerData: [CallerData]?
    
    enum CodingKeys: String, CodingKey {
        case callerData = "data"
    }
    
    init(callerData: [CallerData]) {
        self.callerData = callerData
    }
}

public struct CallerData: Codable {
    
    var id: String?
    var callerId:  Int?
    var streamId: Int?
    var status: String?
    var createdDateTime: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case callerId = "CallerId"
        case streamId = "StreamId"
        case status = "Status"
        case createdDateTime = "CreatedDateTime"
    }
    
    init(id: String?, callerId: Int?, streamId: Int?, status: String?, createdDateTime: String?) {
        self.id = id
        self.callerId = callerId
        self.streamId = streamId
        self.status = status
        self.createdDateTime = createdDateTime
    }
}
