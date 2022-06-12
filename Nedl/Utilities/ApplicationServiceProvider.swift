//
//  ApplicationServiceProvider.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import Foundation
import UIKit

enum Storyboard: String {
    case Main
    case Authentication
    case Studio
    case Profile
    case Tabbar
}

class ApplicationServiceProvider {
    
    static let shared = ApplicationServiceProvider()
    
    let bundleId = Bundle.main.bundleIdentifier ?? ""
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let deviceType = "APPLE"
    
    
    // Manage User Direction
    public func manageUserDirection(from vc: UIViewController? = nil, window: UIWindow? = nil) {
//        guard LocalUser.current() != nil else {
//            directToPath(in: .Authentication, for: .AuthNC, from: vc, window: window)
//            return
//        }
        getRedirectionWithMainInterfaceType(type: ApplicationControl.appMainInterfaceType, window: window)
    }
    
    func getRedirectionWithMainInterfaceType(type: MainInterfaceType, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        switch type {
        case .Main:
            directToPath(in: .Main, for: .HomeNC, from: vc, window: window)
        case .SideMenuNavigations:
            break
//            directToPath(in: .SideMenu, for: .SideMenuConfigurationVC, from: vc, window: window)
        case .TabBarNavigations:
            directToPath(in: .Tabbar, for: .MainTBC, from: vc, window: window)
        case .Custom:
            break
        }
    }
    
    // Direct to Main Root window
    public func directToPath(in sb: Storyboard, for identifier: String, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        appDelegate.setAsRoot(_controller: topController)
    }
    
    public func resetWindow(in sb: Storyboard, for identifier: String, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)

        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
          fatalError("could not get scene delegate ")
        }
        sceneDelegate.window?.rootViewController = topController
    }
    
    public func pushToViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        vc?.navigationController?.pushViewController(destVc, animated: true)
    }
}
