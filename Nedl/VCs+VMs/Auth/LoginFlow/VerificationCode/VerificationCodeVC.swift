//
//  VerificationCodeVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit
import RxSwift
import RxCocoa

class VerificationCodeVC: BaseVC, LandingScreenDelegate {

    // MARK: - Variables
    
    let vm = VerificationCodeVM()
    private let bag = DisposeBag()
    
    var redirectWindow = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var verificationCodeTF: UITextField!
    @IBOutlet weak var btnConfirm        : UIButton!
    @IBOutlet weak var btnRequestNewCode : UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    
    // MARK: - UI Configuration
    
    func configUI() {
        verificationCodeTF.textFieldBoarderOne()
        btnConfirm.layer.cornerRadius = 8
    }

    // MARK: - Outlet Action
    
    @IBAction func didTapOnRequestNewCode(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapOnConfirm(_ sender: UIButton) {
        
//        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .UserUrlVC, from: self)
        verifyCode()
    }
    
    fileprivate func verifyCode() {
        view.endEditing(true)
        
        guard !verificationCodeTF.text!.isEmpty else {
            verificationCodeTF.text = ""
            return
        }
        
        self.startLoading()
        vm.verifyCode(code: verificationCodeTF.text!) { status, message, error in
            self.stopLoading()
            if status {
                let logOption = DataStore.shared.getSignInOption() ?? ""
                
                if logOption == "SignIn" {
                    ApplicationServiceProvider.shared.resetWindow(in: .Tabbar, for: .MainTBC, from: self)
                    
                } else if logOption == "SignUp" {
                    ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .UserUrlVC, from: self)
                }
                
            } else if error != nil {
                self.verificationCodeTF.text = ""
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
        
    }
    
    func didTapOnBtnSignUp(action: String) {
        if action == "SignIn" {
            redirectWindow = 1
        } else {
            redirectWindow = 2
        }
    }
}

