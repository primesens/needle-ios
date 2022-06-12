//
//  AgoraAudioViewController.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-22.
//

import UIKit
import AgoraRtcKit
import AgoraRtmKit

class AgoraAudioViewController: UIViewController {
    
    // MARK: - Variables
    
    var channel: String
    var appId: String
    var token: String?
    var username: String
//    var role: AgoraClientRole
    init(appId: String, token: String?, channel: String, username: String) {
        self.appId = appId
        self.token = token
        self.channel = channel
        self.username = username
//        self.role = role
        super.init(nibName: nil, bundle: nil)
        self.connectAgora()
    }
    
    var speakerTable: UITableView?
    
    var agkit: AgoraRtcEngineKit?
    var rtmkit: AgoraRtmKit?
    var rtmChannel: AgoraRtmChannel?
    var userID: UInt = 0
    var activeSpeakers: Set<UInt> = []
    var activeSpeaker: UInt?
    var activeAudience: Set<UInt> = []
    var usernameLookups: [UInt: String] = [:]
    
    // MARK: - Outlets
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Outlet Action
    
    func connectAgora() {
        // Create connection to RTM
        rtmkit = AgoraRtmKit(appId: self.appId, delegate: self)
        rtmkit?.login(byToken: self.token, user: self.username)
        rtmChannel = rtmkit?.createChannel(withId: channel, delegate: self)
        
        // Create connection to RTC
        agkit = AgoraRtcEngineKit.sharedEngine(withAppId: self.appId, delegate: self)
        agkit?.enableAudio()
        agkit?.enableAudioVolumeIndication(1000, smooth: 3, report_vad: true)
        agkit?.setChannelProfile(.liveBroadcasting)
//        agkit?.setClientRole(role)
    }
    
    func joinChannel() {
        // Connect to Audio RTC
        agkit?.joinChannel(
            byToken: self.token, channelId: self.channel,
            info: nil, uid: self.userID,
            joinSuccess: { (_, uid, _) in
                self.userID = uid
//                if self.role == .audience {
//                    self.activeAudience.insert(uid)
//                } else {
//                    self.activeSpeakers.insert(uid)
//                }
                self.activeSpeakers.insert(uid)
                self.usernameLookups[uid] = self.username
                self.speakerTable?.reloadData()
                // Connect to RTM Channel
                self.rtmChannel?.join(completion: { (errcode) in
                    if errcode == .channelErrorOk {
                        self.shareUserID()
                    }
                })
            }
        )
    }
    
    /// Share RTC userID to either a specific RTM user, or the entire RTM channel
    /// - Parameter username: RTM user to send data to, omit to send to entire channel.
    func shareUserID(to username: String? = nil) {
        if let user = username {
            self.rtmkit?.send(AgoraRtmMessage(text: self.userID.description), toPeer: user)
        } else {
            self.rtmChannel?.send(AgoraRtmMessage(text: self.userID.description))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disconnect() {
        self.rtmChannel?.leave()
        self.agkit?.createRtcChannel(self.channel)?.leave()
        self.rtmkit?.logout()
        self.agkit?.leaveChannel()
        AgoraRtcEngineKit.destroy()
        self.rtmkit?.destroyChannel(withId: self.channel)
    }
    
}
