//
//  OnAirVM.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-30.
//

import UIKit
import Foundation
import Moya


class OnAirVM: NSObject {
    
    // MARK: - Variables
    
    let provider: MoyaProvider<AgoraAPI>
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
    }
    
    var arrCenterImage: [CenterImage] = []
    
    func getCenterImage() {
        arrCenterImage.append(CenterImage(Image: UIImage(named: "Mic3")!))
        arrCenterImage.append(CenterImage(Image: UIImage(named: "unsplash_aCFYbYTyjiQ")!))
    }
    
}

struct CenterImage {
    var Image: UIImage
}

extension OnAirVM {
    
    
    func startStream(completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        let streamUrl = DataStore.shared.getStreamUrl() ?? ""
        
        provider.request(.startStream(streamUrl: streamUrl)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let streamResponse = try response.map(NedlMessage.self)
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
    
    func endStream(completion: @escaping(_ status: Bool, _ message: String?, _ validationError: String?) -> Void){
        
        // Checking for Internet connection availability
        guard Reachability.isInternetAvailable() else {
            completion(false, "503", .InternetConnectionOffline)
            return
        }
        
        let streamUrl = DataStore.shared.getStreamUrl() ?? ""
        
        provider.request(.endStream(streamUrl: streamUrl)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let streamResponse = try response.map(NedlMessage.self)
                    completion(true, streamResponse.message, nil)
                } catch {
                    completion(false, nil, "We're having trouble connecting to the server, please try again")
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(NedlError.self) else {
                        return completion(false, nil, "You are not authorized to end the stream")
                    }
                    completion(false, nil, errorResponse.message)
                } catch {
                    completion(false, nil, "map error")
                }
                
            }
        }
    }
}
