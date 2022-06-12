//
//  LoungeVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-25.
//

import UIKit
import RxSwift
import RxCocoa

class LoungeVC: BaseVC {

    let vm = LoungeVM()
    private let bag = DisposeBag()
    
    @IBOutlet weak var lblStreamUrl: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblShareUrl: UILabel!
    @IBOutlet weak var btnPrivacy: UIButton!
    @IBOutlet weak var btnPublic: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var entryFeeTF: UITextField!
    @IBOutlet weak var btnShareUrl: UIButton!
    @IBOutlet weak var statusContainerView: UIView!
    @IBOutlet weak var feeContainerView: UIView!
    
    @IBOutlet weak var guestOneImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        getRTCToken()
    }
    

    func configUI() {
        let userUrl = DataStore.shared.getStreamUrl() ?? ""
        lblStreamUrl.text = userUrl
        lblShareUrl.text = userUrl
        
        btnShare.layer.cornerRadius = 8
        lblStatus.text = "Public"
        lblShareUrl.isHidden = true
        btnPublic.isHidden = true
        btnShareUrl.isHidden = true
        statusContainerView.viewPropertiesTwo()
        feeContainerView.viewPropertiesTwo()
    }

    @IBAction func didTapOnBtnPublic(_ sender: UIButton) {
//        btnPrivacy.isHidden = false
//        btnPublic.isHidden = true
//        lblShareUrl.isHidden = true
//        btnShareUrl.isHidden = false
//        lblStatus.text = "Public"
        getProfile()
    }
    
    @IBAction func didTapOnBtnPrivacy(_ sender: UIButton) {
        btnPrivacy.isHidden = true
        btnPublic.isHidden = false
        lblShareUrl.isHidden = false
        btnShareUrl.isHidden = true
        lblStatus.text = "Privacy"
        
    }
    
    @IBAction func didTapOnGoOnAir(_ sender: UIButton) {
        ApplicationServiceProvider.shared.pushToViewController(in: .Studio, for: .CountDownTimerVC, from: self)
//        ApplicationServiceProvider.shared.resetWindow(in: .Main, for: .OnAirVC, from: self)
    }
    
    fileprivate func getRTCToken() {
        self.startLoading()
        vm.getRtcToken() { status, message, error in
            self.stopLoading()
            if status {
                let rtcToken = DataStore.shared.getRTCToken() ?? ""
                print(rtcToken)
//                self.startStream()
            } else if error != nil {
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
    
    fileprivate func getProfile() {
        self.startLoading()
        vm.getProfile() { status, message, error in
            self.stopLoading()
            if status {
                
                print("success")
//                self.startStream()
            } else if error != nil {
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
}
