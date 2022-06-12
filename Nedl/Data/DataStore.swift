//
//  DataStore.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import Foundation
import UIKit
import Moya

class DataStore {
    
    let provider: MoyaProvider<AuthAPI> = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin()])
    
    static let shared  = DataStore()
    
    private init(){}
    
    func setCallerId(callerId: String) {
        UserDefaults.standard.set(callerId, forKey: "callerId")
    }
    
    func getCallerId() -> String? {
        return UserDefaults.standard.string(forKey: "callerId")
    }
    
    func setUID(uid: String) {
        UserDefaults.standard.set(uid, forKey: "uid")
    }
    
    func getUID() -> String? {
        return UserDefaults.standard.string(forKey: "uid")
    }
    
    func setSignInOption(signInOption: String) {
        UserDefaults.standard.set(signInOption, forKey: "signInOption")
    }
    
    func getSignInOption() -> String? {
        return UserDefaults.standard.string(forKey: "signInOption")
    }
    
    func setRTCToken(rtcToken: String) {
        UserDefaults.standard.set(rtcToken, forKey: "rtcToken")
    }
    
    func getRTCToken() -> String? {
        return UserDefaults.standard.string(forKey: "rtcToken")
    }
    
    func setUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: "userName")
    }
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
    
    func setStreamUrl(streamUrl: String) {
        UserDefaults.standard.set(streamUrl, forKey: "streamUrl")
    }
    
    func getStreamUrl() -> String? {
        return UserDefaults.standard.string(forKey: "streamUrl")
    }
    
    func setPhoneNumber(phoneNumber: String) {
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
    }
    
    func getPhoneNumber() -> String? {
        return UserDefaults.standard.string(forKey: "phoneNumber")
    }
    
    func setHashCode(hashCode: String) {
        UserDefaults.standard.set(hashCode, forKey: "hashCode")
    }
    
    func getHashCode() -> String? {
        return UserDefaults.standard.string(forKey: "hashCode")
    }
    
    func setAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func removeAllData(completion: @escaping() -> Void) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
      
        setLastTimeStampUploadedToAPI(token: 0)
        completion()
    }
    
    func setLastTimeStampUploadedToAPI(token: Int) {
        UserDefaults.standard.set(token, forKey: "timeStamp")
    }
    
    func getLastTimeStampUploadedToAPI() -> Int {
        return UserDefaults.standard.integer(forKey: "timeStamp")
    }
}

