//
//  VerificationCodeVM.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit
import Foundation
import Moya

class VerificationCodeVM: NSObject {

    // MARK: - Variables
    
    let provider: MoyaProvider<AuthAPI>
    var canGoBack: Bool
    var userPhoneNumber: String
    var afterCreate: Bool = false
    var afterReset: Bool = false
    
    init(canGoBack: Bool = true,userPhoneNumber: String = "",afterReset: Bool = false) {
        self.canGoBack = canGoBack
        self.userPhoneNumber = userPhoneNumber
        if afterReset {
            self.afterReset = afterReset
        }else if !userPhoneNumber.isEmpty{
            self.afterCreate = true
        }
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<AuthAPI>(plugins: [networkLogger])
    }
}

extension VerificationCodeVM {
    func verifyCode(code: String, completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void) {
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        let userPhoneNumber = DataStore.shared.getPhoneNumber() ?? ""
        let userHashCode = DataStore.shared.getHashCode() ?? ""
        provider.request(.verifyCode(phone: userPhoneNumber, code: code, hash: userHashCode)) { result in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let verifyCodeResult = try response.map(AuthTokensResult.self)
                    DataStore.shared.setAccessToken(token: verifyCodeResult.token)
                    DataStore.shared.setUID(uid: verifyCodeResult.user.id ?? "0")
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
