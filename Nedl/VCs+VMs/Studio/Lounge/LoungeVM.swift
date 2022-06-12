//
//  LoungeVM.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-25.
//

import UIKit
import Foundation
import Moya

class LoungeVM: NSObject {

    // MARK: - Variables
    
    let provider: MoyaProvider<AgoraAPI>
    let provider2: MoyaProvider<AuthAPI>
    var canGoBack: Bool
    var afterCreate: Bool = false
    var afterReset: Bool = false
    
    init(canGoBack: Bool = true,afterReset: Bool = false) {
        self.canGoBack = canGoBack
        if afterReset {
            self.afterReset = afterReset
        }
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<AgoraAPI>(plugins: [networkLogger])
        provider2 = MoyaProvider<AuthAPI>(plugins: [networkLogger])
    }
}

extension LoungeVM {
    
    func getRtcToken(completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        let streamUrl = DataStore.shared.getStreamUrl() ?? ""
        
        provider.request(.getRTCToken(streamUrl: streamUrl)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let rtcTokenResult = try response.map(RTCTokenResult.self)
                    DataStore.shared.setRTCToken(rtcToken: rtcTokenResult.rtcToken)
                    completion(true, "Success", nil)
                } catch {
                    completion(false, nil, "We're having trouble connecting to the server, please try again")
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(NedlError.self) else {
                        return completion(false, nil, "map error")
                    }
                    completion(false, nil, errorResponse.message)
                } catch {
                    completion(false, nil, "map error")
                }
                
            }
        }
    }
    
    
    func getProfile(completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        
        
        provider2.request(.getProfile) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let getProfile = try response.map(RTCTokenResult.self)
                    
                    completion(true, "Success", nil)
                } catch {
                    completion(false, nil, "We're having trouble connecting to the server, please try again")
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(NedlError.self) else {
                        return completion(false, nil, "map error")
                    }
                    completion(false, nil, errorResponse.message)
                } catch {
                    completion(false, nil, "map error")
                }
                
            }
        }
    }
}
