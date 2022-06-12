//
//  BroadcastVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-24.
//

import UIKit

class BroadcastVC: UIViewController {
    
    // MARK: - Variables
    
    static var appID: String = "4880e7f0ad5f428c9547f12d6bc115d7"
    
    // MARK: - Outlets
    
    @IBOutlet weak var channelTF: UITextField!
    @IBOutlet weak var tokenTF: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var btnLeave: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - UI Configuration
    
    func configUI() {
        channelTF.textFieldBoarderOne()
        tokenTF.textFieldBoarderOne()
        btnJoin.layer.cornerRadius = 8
        btnMute.buttonPropertiesOne()
        btnLeave.buttonPropertiesOne()
    }
    
    @objc func joinChannel() {
        let channel = self.channelTF.text ?? ""
        let username = self.tokenTF.text ?? ""
//        let role: AgoraClientRole = self.toggleRole.selectedSegmentIndex == 0 ?
//            .audience : .broadcaster
        if channel.isEmpty || username.isEmpty {
            return
        }
        let agoraAVC = AgoraAudioViewController(
            appId: BroadcastVC.appID, token: nil,
//            channel: channel, username: username, role: role
            channel: channel, username: username
        )
        agoraAVC.presentationController?.delegate = self
        self.present(agoraAVC, animated: true)
    }
    
    // MARK: - Outlet Action
    
    @IBAction func didTapOnBtnJoin(_ sender: UIButton) {
        joinChannel()
    }
    
}

extension BroadcastVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        guard let videoViewer = (
                presentationController.presentedViewController as? AgoraAudioViewController
        ) else {
            return
        }
        videoViewer.disconnect()
    }
}
