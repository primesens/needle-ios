//
//  AuthTokensResult.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation


// MARK: - AuthTokensResult
class AuthTokensResult: Codable {
    
    let token: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }

    init(token: String, user: User) {
        
        self.token = token
        self.user = user
    }
}

// MARK: - User
class User: Codable {
    
    var id: String?
    var AuthSource: String?
    var Phone: String?
    var UID: String?
    var StreamUrl: String?
    var Name: String?
    var HandleName: String?
    var CreatedDateTime: String?
    var UserType: Int?
    var DefaultScansImported: Bool?
    var AvatarUrl: String?
    var Hays: Int?
    var ChargeAmount: String?
    var ChargeDateTime: String?
    var subscriptionMinutes: String?
    var ChargeID: String?
    var HomeStationId: String?
    var HomeStationUrl: String?
    var HomeStationToken: String?
    var HomeStationType: String?
    var HomeStationTranscriptType: String?
    var HomeStationLogoUrl: String?
    var ActiveSubscription: Bool?
    var SubscriptionType: String?
    var HomeStation: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case AuthSource = "AuthSource"
        case Phone = "Phone"
        case UID = "UID"
        case StreamUrl = "StreamUrl"
        case Name = "Name"
        case HandleName = "HandleName"
        case CreatedDateTime = "CreatedDateTime"
        case UserType = "UserType"
        case DefaultScansImported = "DefaultScansImported"
        case AvatarUrl = "AvatarUrl"
        case Hays = "Hays"
        case ChargeAmount = "ChargeAmount"
        case ChargeDateTime = "ChargeDateTime"
        case subscriptionMinutes = "subscriptionMinutes"
        case ChargeID = "ChargeID"
        case HomeStationId = "HomeStationId"
        case HomeStationUrl = "HomeStationUrl"
        case HomeStationToken = "HomeStationToken"
        case HomeStationType = "HomeStationType"
        case HomeStationTranscriptType = "HomeStationTranscriptType"
        case HomeStationLogoUrl = "HomeStationLogoUrl"
        case ActiveSubscription = "ActiveSubscription"
        case HomeStation = "HomeStation"
        
    }

    init(id: String?, AuthSource: String?, Phone: String?, UID: String?, StreamUrl: String?, Name: String?, HandleName: String?, CreatedDateTime: String?, UserType: Int?, DefaultScansImported: Bool?, AvatarUrl: String?, Hays: Int?, ChargeAmount: String?, ChargeDateTime: String?, subscriptionMinutes: String?, ChargeID: String?, HomeStationId: String?, HomeStationUrl: String?, HomeStationToken: String?, HomeStationType: String?, HomeStationTranscriptType: String?, HomeStationLogoUrl: String?, ActiveSubscription: Bool?, SubscriptionType: String?, HomeStation: String?) {
        
        self.id = id
        self.AuthSource = AuthSource
        self.Phone = Phone
        self.UID = UID
        self.StreamUrl = StreamUrl
        self.Name = Name
        self.HandleName = HandleName
        self.CreatedDateTime = CreatedDateTime
        self.UserType = UserType
        self.DefaultScansImported = DefaultScansImported
        self.AvatarUrl = AvatarUrl
        self.Hays = Hays
        self.ChargeAmount = ChargeAmount
        self.ChargeDateTime = ChargeDateTime
        self.subscriptionMinutes = subscriptionMinutes
        self.ChargeID = ChargeID
        self.HomeStationId = HomeStationId
        self.HomeStationUrl = HomeStationUrl
        self.HomeStationToken = HomeStationToken
        self.HomeStationType = HomeStationType
        self.HomeStationTranscriptType = HomeStationTranscriptType
        self.HomeStationLogoUrl = HomeStationLogoUrl
        self.ActiveSubscription = ActiveSubscription
        self.SubscriptionType = SubscriptionType
        self.HomeStation = HomeStation
    }
}

