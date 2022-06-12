//
//  OnAirVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-30.
//

import UIKit
import RxSwift
import RxCocoa
import AgoraRtcKit
import AgoraRtmKit
import AVFoundation

protocol OnAirDelegate {
    func didTapOnMuteBtn(action: String)
    func didTapOnUnMuteBtn(action: String)
}

class OnAirVC: BaseVC {
    
    // MARK: - Variables
    
    let vm = OnAirVM()
    private let bag = DisposeBag()
    var delegate : OnAirDelegate?
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var thisWidth:CGFloat = 0
    var agoraKit: AgoraRtcEngineKit?
    var rtmkit: AgoraRtmKit?
    var rtmChannel: AgoraRtmChannel?
    
    let rtcToken = DataStore.shared.getRTCToken() ?? ""
    let streamUrl = DataStore.shared.getStreamUrl() ?? ""
    let uid = DataStore.shared.getUID() ?? "0"
    
   
//    var newUID = UInt(uid)
    
    // MARK: - Outlets
    
    @IBOutlet weak var viewersView: UIView!
    @IBOutlet weak var lblViewers: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var centerCollectionView: UICollectionView! {
        didSet {
            centerCollectionView.dataSource = self
            centerCollectionView.delegate = self
        }
    }
    @IBOutlet weak var centerPageControl: UIPageControl!
    @IBOutlet weak var hastagView: UIView!
    @IBOutlet weak var lblHasgtag: UILabel!
    @IBOutlet weak var lblCustomUrl: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnStationId: UIButton!
    @IBOutlet weak var btnIntroOutro: UIButton!
    @IBOutlet weak var btnSponsor: UIButton!
    
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var btnAds: UIButton!
    @IBOutlet weak var btnCalls: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var btnUnmute: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        vm.getCenterImage()
        setDelegate(from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // The user granted access. Present recording interface.
                print("S")
            } else {
                print("F")
            }
        }
        
        
        startStream()
    }
    
    func setDelegate(from vc: UIViewController) {
        self.delegate = vc as? OnAirDelegate
    }
    
    func initializeAndJoinChannel() {
        // Pass in your App ID here
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "4880e7f0ad5f428c9547f12d6bc115d7", delegate: self)
        
        // For a live streaming scenario, set the channel profile as liveBroadcasting.
        agoraKit?.setChannelProfile(.liveBroadcasting)
        // And set the client role as broadcaster or audience.
        agoraKit?.setClientRole(.broadcaster)
        print(uid)
        agoraKit?.enableAudio()
        agoraKit?.adjustRecordingSignalVolume(50)
        agoraKit?.enableAudioVolumeIndication(1000, smooth: 3, report_vad: false)
        agoraKit?.setEnableSpeakerphone(true)
        // Join the channel with a token. Pass in your token and channel name here
        
        // Set audio route to speaker
        agoraKit?.setDefaultAudioRouteToSpeakerphone(true)
        // enable local voice pitch
        agoraKit?.enableLocalVoicePitchCallback(200)
        
        let newUid = UInt(uid)
        print(newUid)
        agoraKit?.joinChannel(byToken: rtcToken, channelId: streamUrl, info: nil, uid: UInt(uid) ?? 0, joinSuccess: { (channel, uid, elapsed) in
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        agoraKit?.leaveChannel(nil)
        self.rtmkit?.destroyChannel(withId: streamUrl)
    }
    
    // MARK: - UI Configuration
    
    func configUI() {
        let userUrl = DataStore.shared.getStreamUrl() ?? ""
        lblCustomUrl.text = userUrl
        
        btnUnmute.isHidden = true
        
        viewersView.layer.cornerRadius = 6
        viewersView.layer.borderWidth = 1
        viewersView.layer.borderColor = #colorLiteral(red: 0.9297742844, green: 0.3123705387, blue: 0.3272885084, alpha: 1)
        
        locationView.layer.cornerRadius = 6
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = #colorLiteral(red: 0.9297742844, green: 0.3123705387, blue: 0.3272885084, alpha: 1)
        
        btnShare.layer.cornerRadius = 6
        
        centerCollectionView.layer.cornerRadius = centerCollectionView.layer.bounds.width / 2
        
        btnStationId.layer.cornerRadius = btnStationId.layer.bounds.width / 2
        btnIntroOutro.layer.cornerRadius = btnIntroOutro.layer.bounds.width / 2
        btnSponsor.layer.cornerRadius = btnSponsor.layer.bounds.width / 2
        
    }
    
    // MARK: - ConfigPageControl
    
    func configPageControl() {
        centerPageControl.currentPage = 0
        centerPageControl.isUserInteractionEnabled = false
        thisWidth = CGFloat(self.frame.width)
        centerPageControl.hidesForSinglePage = true
    }
    
    // MARK: - Outlet Action
    
    @IBAction func didTapOnCommets(_ sender: UIButton) {
        CommentView.instance.showCommentView(from: self)
        btnComments.setImage(UIImage(named: "CommentSelected"), for: .normal)
    }
    @IBAction func didTapOnCalls(_ sender: UIButton) {
        CallersView.instance.showCallView(from: self)
        btnCalls.setImage(UIImage(named: "CallSelected"), for: .normal)
    }
    
    @IBAction func didTapOnAdsBtn(_ sender: UIButton) {
        AddsView.instance.showAdView(from: self)
        btnAds.setImage(UIImage(named: "AdsSelected"), for: .normal)
    }
    
    @IBAction func didTapOnSearchBtn(_ sender: UIButton) {
        SearchView.instance.showSearchView(from: self)
        btnSearch.setImage(UIImage(named: "SearchSelected"), for: .normal)
    }
    
    @IBAction func didTapOnExit(_ sender: UIButton) {
        ExitView.instance.showExitView(from: self)
    }
    
    @IBAction func didTapOnBtnMute(_ sender: UIButton) {
        delegate?.didTapOnMuteBtn(action: "Mute")
        agoraKit?.disableAudio()
        btnMute.isHidden = true
        btnUnmute.isHidden = false
    }
    
    @IBAction func didTapOnBtnUnmute(_ sender: UIButton) {
        delegate?.didTapOnUnMuteBtn(action: "UnMute")
        agoraKit?.enableAudio()
        btnUnmute.isHidden = true
        btnMute.isHidden = false
    }
    
    // MARK: - API Call
    
    fileprivate func startStream() {
        self.startLoading()
        vm.startStream() { status, message, error in
            self.stopLoading()
            if status {
                self.initializeAndJoinChannel()
            } else if error != nil {
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
    
    fileprivate func endStream() {
        self.startLoading()
        vm.endStream()  { status, message, error in
            self.stopLoading()
            if status {
                self.leaveChannel()
                ApplicationServiceProvider.shared.resetWindow(in: .Tabbar, for: .MainTBC, from: self)
            } else if error != nil {
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
    
    func leaveChannel() {
        self.rtmChannel?.leave()
        self.agoraKit?.createRtcChannel("streamtestGNew")?.leave()
        self.rtmkit?.logout()
        self.agoraKit?.leaveChannel()
        AgoraRtcEngineKit.destroy()
    }
}

extension OnAirVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.arrCenterImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CenterCVC = centerCollectionView.dequeueReusableCell(withReuseIdentifier: "CenterCVC", for: indexPath) as! CenterCVC
        cell.configCell(model: vm.arrCenterImage[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        centerPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension OnAirVC: AddsViewDelegate, SearchViewDelegate, CommentViewDelegate, CallersViewDelegate, ExitViewDelegate {
    
    
    func didTapOnExitBtn(action: String) {
        if action == "Exit" {
            btnAds.setImage(UIImage(named: "AddsButton"), for: .normal)
            btnSearch.setImage(UIImage(named: "SearchButton"), for: .normal)
            btnCalls.setImage(UIImage(named: "PhoneButton"), for: .normal)
            btnComments.setImage(UIImage(named: "CommentButton"), for: .normal)
        }
    }
    
    func didTapOnConfirmExitBtn(action: String) {
        if action == "Confirm" {
            self.endStream()
        }
    }
}

//extension OnAirVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = centerCollectionView.frame.width - 5
//        let height = centerCollectionView.frame.height - 5 
//        return CGSize(width: width, height: height)
//    }
//}

extension OnAirVC: AgoraRtcEngineDelegate {
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
    }
    
    
}
