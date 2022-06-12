//
//  NumberVM.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit
import Foundation
import Moya
import RxCocoa
import RxSwift

class NumberVM: NSObject, ValidatorDelegate {
    
    // MARK: - Variables
    
    let provider: MoyaProvider<AuthAPI>
    var canGoBack: Bool
    var userPhoneNumber: String
    var afterCreate: Bool = false
    var afterReset: Bool = false
    
    var mobile             = BehaviorRelay<String>(value: "")
    var isErrorMobile      = BehaviorRelay<Bool>(value: false)
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
    
    func validateNumber() throws -> Bool {
        var errors: [String] = []
        
        if mobile.value.trim().isEmpty { 
            errors.append(.PhoneEmpty)
        } else if !isValidPhoneNumber(phone: mobile.value) {
            errors.append(.InvalidPhone)
        }
        
        if errors.isEmpty {
            return true
        } else {
            throw ValidateError.invalidDatas(errors)
        }
    }
    
    // MARK: - Validate and signup Calling Function
    
    func validateAndProceed(completion: actionHandlerForMultipleErrors) {
        do {
            if try validateNumber() {
                completion(true, [.Success])
            }
        } catch ValidateError.invalidDatas(let errors) {
            completion(false, errors)
        } catch {
            completion(false, [.MisingData])
        }
    }
}

extension NumberVM {
    func sendCode(phoneNumber: String, completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        provider.request(.sendCode(phone: phoneNumber, userType: "Individual")) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let sendCode = try response.map(NedlGenericSuccess.self)
                    DataStore.shared.setHashCode(hashCode: sendCode.code)
                    completion(true, sendCode.message, nil)
                } catch {
                    completion(false, nil, "We're having trouble connecting to the server, please try again")
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(NedlError.self) else {
                        return completion(false, nil, "Invalid Number")
                    }
                    completion(false, nil, errorResponse.message)
                } catch {
                    completion(false, nil, "The number has been already taken")
                }
                
            }
        }
        
    }
    
    func sendCodeLogin(phoneNumber: String, completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        provider.request(.login(phone: phoneNumber)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let sendCode = try response.map(NedlLoginSuccess.self)
                    DataStore.shared.setHashCode(hashCode: sendCode.code)
                    completion(true, sendCode.message, nil)
                } catch {
                    completion(false, nil, "We're having trouble connecting to the server, please try again")
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(NedlError.self) else {
                        return completion(false, nil, "The number has been already taken")
                    }
                    completion(false, nil, errorResponse.message)
                } catch {
                    completion(false, nil, "The number has been already taken")
                }
                
            }
        }
        
    }
}
