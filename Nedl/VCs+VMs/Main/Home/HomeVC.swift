//
//  HomeVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlet Action

    @IBAction func didTapOnLogout(_ sender: UIButton) {
        ApplicationServiceProvider.shared.resetWindow(in: .Authentication, for: .SignInVC, from: self)
    }
    
}
