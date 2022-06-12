//
//  GoOnAirBaseVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-25.
//

import UIKit

class GoOnAirBaseVC: UIViewController {

    @IBOutlet weak var lblCustomUrl: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    

    func configUI() {
        btnShare.layer.cornerRadius = 8
        let userUrl = DataStore.shared.getStreamUrl() ?? ""
        lblCustomUrl.text = userUrl
    }

    @IBAction func didTapOnBtnGoAir(_ sender: UIButton) {
        ApplicationServiceProvider.shared.pushToViewController(in: .Studio, for: .LoungeVC, from: self)
    }
}
