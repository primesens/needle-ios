//
//  UserUrlVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit
import RxSwift
import RxCocoa

class UserUrlVC: BaseVC {

    // MARK: - Variables
    
    let vm = UserUrlVM()
    private let bag = DisposeBag()
    
    // MARK: - Outlets
    
    @IBOutlet weak var fullNameTF   : UITextField!
    @IBOutlet weak var urlTF        : UITextField!
    @IBOutlet weak var urlCheckImage: UIImageView!
    @IBOutlet weak var btnConfirm   : UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: - UI Configuration
    
    func configUI() {
        fullNameTF.textFieldBoarderOne()
        urlTF.textFieldBoarderOne()
        btnConfirm.layer.cornerRadius = 8
    }

    // MARK: - Outlet Action
    
    @IBAction func didTapOnConfirm(_ sender: UIButton) {
//        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .SuccessVC, from: self)
        createStreamUrl()
    }
    
    fileprivate func createStreamUrl() {
        view.endEditing(true)
        
        guard !urlTF.text!.isEmpty else {
            urlTF.text = ""
            return
        }
        
//        let streamUrl = "nedl.com/" + urlTF.text!
        let streamUrl = urlTF.text!
        print(streamUrl)
        self.startLoading()
        let token = DataStore.shared.getAccessToken() ?? ""
        vm.userUrl(fullName: fullNameTF.text!, customUrl: streamUrl) { status, message, error in
            self.stopLoading()
            if status {
                ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .SuccessVC, from: self)
            } else if error != nil {
                self.fullNameTF.text = ""
                self.urlTF.text = ""
                self.presentAlert(title: "", message: error ?? "", buttonTitle: "OK")
            }
        }
    }
}
