//
//  UserUrlVM.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit
import Foundation
import Moya

class UserUrlVM: NSObject {
    
    // MARK: - Variables
    
    let provider: MoyaProvider<AuthAPI>
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
        provider = MoyaProvider<AuthAPI>(plugins: [networkLogger])
    }
}

extension UserUrlVM {
    func userUrl(fullName: String , customUrl: String, completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void) {
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        DataStore.shared.setUserName(userName: fullName)
        DataStore.shared.setStreamUrl(streamUrl: customUrl)
        
        provider.request(.streamUrl(streamUrl: customUrl)) { result in
            switch result {
            case let .success(response):
                print(response)
                do {
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

