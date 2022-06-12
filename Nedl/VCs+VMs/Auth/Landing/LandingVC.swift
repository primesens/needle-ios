//
//  LandingVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit

protocol LandingScreenDelegate {
    func didTapOnBtnSignUp(action: String)
}

class LandingVC: UIViewController {
    
    // MARK: - Vairables

    var delegate : LandingScreenDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var btnGetUrl: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
//        setDelegate(from: self)
    }

    // MARK: - UI Configuration
    
    func configUI() {
        btnGetUrl.layer.cornerRadius = 8
        btnSignIn.layer.cornerRadius = 8
        btnSignIn.layer.borderWidth = 1
        btnSignIn.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: - Outlet Action
    
    @IBAction func didTapOnGetUrl(_ sender: UIButton) {
//        ApplicationServiceProvider.shared.pushToViewController(in: .Studio, for: .NewUserLandingVC, from: self)
//        DataStore.shared.setStreamUrl(streamUrl: "streamtestGNew")
        DataStore.shared.setSignInOption(signInOption: "SignUp")
        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .NumberVC, from: self)
    }
    
    @IBAction func didTapOnSignIn(_ sender: UIButton) {
        DataStore.shared.setSignInOption(signInOption: "SignIn")
        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .NumberVC, from: self)
    }
}
