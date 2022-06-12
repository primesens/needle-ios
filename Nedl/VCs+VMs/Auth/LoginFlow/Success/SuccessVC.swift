//
//  SuccessVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import UIKit

class SuccessVC: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    
    @IBOutlet weak var btnContinue: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    

    // MARK: - UI Configuration
    
    func configUI() {
        btnContinue.layer.cornerRadius = 8
    }
    
    // MARK: - Outlet Action
    
    @IBAction func didTapOnBtnContinue(_ sender: UIButton) {
//        ApplicationServiceProvider.shared.resetWindow(in: .Tabbar, for: .MainTBC, from: self)
        ApplicationServiceProvider.shared.pushToViewController(in: .Studio, for: .NewUserLandingVC, from: self)
//        ApplicationServiceProvider.shared.resetWindow(in: .Main, for: .OnAirVC)
    }
    
}
