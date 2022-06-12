//
//  SignInVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import UIKit

class SignInVC: UIViewController {
    
    // MARK: - Variables
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Outlet Action
    
    @IBAction func didTapOnForgotPassword(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapOnSignIn(_ sender: UIButton) {
        ApplicationServiceProvider.shared.resetWindow(in: .Main, for: .HomeVC, from: self)
    }
    
    @IBAction func didTapOnSignUp(_ sender: UIButton) {
        ApplicationServiceProvider.shared.resetWindow(in: .Authentication, for: .SignUpVC, from: self)
    }
}
