//
//  CallData.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import Foundation
import UIKit
import Moya
import RxCocoa
import RxSwift

class CallData: NSObject {
    
    // MARK: - Variables
    
    let provider: MoyaProvider<AgoraAPI>
    var canGoBack: Bool
    var userPhoneNumber: String
    var afterCreate: Bool = false
    var afterReset: Bool = false
    
    let streamUrl = DataStore.shared.getStreamUrl() ?? ""
    var calleData         = Variable<[CallerData]>([])
    
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
        provider = MoyaProvider<AgoraAPI>(plugins: [networkLogger])
    }
    
//    var arrCalls: [Call] = []
//
//    func getCalls() {
//        arrCalls.append(Call(userImage: UIImage(named: "UserImage")!, Name: "John Doe"))
//        arrCalls.append(Call(userImage: UIImage(named: "UserImage")!, Name: "John Doe"))
//        arrCalls.append(Call(userImage: UIImage(named: "UserImage")!, Name: "John Doe"))
//        arrCalls.append(Call(userImage: UIImage(named: "UserImage")!, Name: "John Doe"))
//        arrCalls.append(Call(userImage: UIImage(named: "UserImage")!, Name: "John Doe"))
//    }
}

extension CallData {
    func getCallers(completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        
        
        provider.request(.getCaller(streamUrl: "goodboi")) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    
                    let callerResult = try response.map(CallerResult.self)
                    self.calleData.value.append(contentsOf: callerResult.callerData ?? [])
                    
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
    
    func addCaller(callerUrl: String, callerId: Int, status: String, completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        
        
        provider.request(.addCaller(streamUrl: "Url", callerId: 62, status: "ACCEPTED")) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    
                    let _response = try response.map(NedlMessage.self)
                    
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
    
    func endCaller(callerUrl: String, callerId: Int, status: String, completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        
        provider.request(.endCaller(streamUrl: "Url", callerId: 62, status: "ACCEPTED")) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    
                    let _response = try response.map(NedlMessage.self)
                    
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
