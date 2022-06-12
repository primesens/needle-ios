//
//  SignUpVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Outlet Action

    @IBAction func didTapOnSignUp(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapOnSignIn(_ sender: UIButton) {
        ApplicationServiceProvider.shared.resetWindow(in: .Authentication, for: .SignInVC, from: self)
    }
}
