//
//  NewUserLandingVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-25.
//

import UIKit

class NewUserLandingVC: UIViewController {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var btnProceed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    

    func configUI() {
        detailView.viewPropertiesTwo()
        btnProceed.layer.cornerRadius = 8
    }
   
    @IBAction func didTapOnBtnProceed(_ sender: UIButton) {
        ApplicationServiceProvider.shared.resetWindow(in: .Tabbar, for: .MainTBC, from: self)
    }
    
}
