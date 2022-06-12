//
//  AppDelegate.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import UIKit
import PusherSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, PusherDelegate{
    
    var window: UIWindow?
    var pusher: Pusher!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let options = PusherClientOptions(
            host: .cluster("us3")
        )
        
        pusher = Pusher(
            key: "a924587349347e93fbc5",
            options: options
        )
        
        pusher.delegate = self
        
        // subscribe to channel
        let channel = pusher.subscribe("nedl-sandbox")
        
        // bind a callback to handle an event
        let _ = channel.bind(eventName: "my-event", eventCallback: { (event: PusherEvent) in
            if let data = event.data {
                // you can parse the data as necessary
                print(data)
            }
        })
        
        pusher.connect()
        
        return true
    }
    
    // print Pusher debug messages
    func debugLog(message: String) {
        print(message)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func setAsRoot(_controller: UIViewController) {
        if window != nil {
            window?.rootViewController = _controller
        }
    }
}

