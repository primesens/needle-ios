//
//  NumberVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit
import RxSwift
import RxCocoa
import ADCountryPicker

class NumberVC: BaseVC, ADCountryPickerDelegate, ValidatorDelegate {
    
    // MARK: - Variables
    
    let vm = NumberVM()
    private let bag = DisposeBag()
    
    let picker = ADCountryPicker()
    
    var countryCode = "+1"
    var mobileNumber = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var numberTF         : UITextField!
    @IBOutlet weak var btnNext          : UIButton!
    @IBOutlet weak var btnTermsCondition: UIButton!
    @IBOutlet weak var btnPrivacyPolicy : UIButton!
    @IBOutlet weak var btnCountryPicker : UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObeserver()
        configUI()
        picker.delegate = self
    }
    
    // MARK: - UI Configuration
    
    func configUI() {
        numberTF.textFieldBoarderOne()
        btnNext.layer.cornerRadius = 8
        
        
        picker.showCallingCodes = true
        picker.showFlags = true
        picker.defaultCountryCode = "US"
    }
    
    func addObeserver() {
        numberTF.rx.text
            .orEmpty
            .bind(to: vm.mobile)
            .disposed(by: bag)
        
        numberTF.rx.text.asObservable()
            .subscribe { _ in
                self.vm.mobile.accept(self.vm.mobile.value.replacingOccurrences(of: "[^+0-9]", with: "", options: .regularExpression))
                if self.isValidPhoneNumber(phone: self.vm.mobile.value) {
                    self.vm.isErrorMobile.accept(false)
                }
            }.disposed(by: bag)
    }
    
    
    // MARK: - Outlet Action
    
    @IBAction func didTapOnBtnCountryPicker(_ sender: UIButton) {
        
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnTermsCondition(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapOnPrivacyPolicy(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapOnNext(_ sender: UIButton) {
        let logOption = DataStore.shared.getSignInOption() ?? ""
        
        if logOption == "SignIn" {
            login()
        } else if logOption == "SignUp" {
            sendCode()
        }
        
        //        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .VerificationCodeVC, from: self)
    }
    
    fileprivate func sendCode() {
        view.endEditing(true)
        
        guard !numberTF.text!.isEmpty else {
            numberTF.text = ""
            return
        }
        mobileNumber = countryCode + numberTF.text!
        
        self.startLoading()
        vm.sendCode(phoneNumber: mobileNumber) { status, message, error in
            self.stopLoading()
            DataStore.shared.setPhoneNumber(phoneNumber: self.mobileNumber)
            if status {
                ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .VerificationCodeVC, from: self)
            } else if error != nil {
                self.numberTF.text = ""
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
    
    fileprivate func login() {
        view.endEditing(true)
        
        guard !numberTF.text!.isEmpty else {
            numberTF.text = ""
            return
        }
        
        mobileNumber = countryCode + numberTF.text!
        self.startLoading()
        vm.sendCodeLogin(phoneNumber: mobileNumber) { status, message, error in
            self.stopLoading()
            DataStore.shared.setPhoneNumber(phoneNumber: self.mobileNumber)
            if status {
                ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .VerificationCodeVC, from: self)
            } else if error != nil {
                self.numberTF.text = ""
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        if textField == numberTF {
    //            numberTF.becomeFirstResponder()
    //        }
    //        return true
    //    }
    
    //    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
    //        print(name)
    //    }
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        print(name)
        print(dialCode)
        
        countryCode = dialCode
        
        
    }
}
