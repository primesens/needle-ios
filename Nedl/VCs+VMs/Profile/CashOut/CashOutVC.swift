//
//  CashOutVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-11.
//

import UIKit

class CashOutVC: UIViewController {

    // MARK: - Variables
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblHayCollected: UILabel!
    @IBOutlet weak var lblUsd: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: - UI Configuration
    
    func configUI() {
        btnChange.buttonPropertiesThree()
    }

    
}
