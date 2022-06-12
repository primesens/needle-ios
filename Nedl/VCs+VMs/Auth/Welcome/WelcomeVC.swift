//
//  WelcomeVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-22.
//

import UIKit

class WelcomeVC: UIViewController {

    // MARK: - Variables
    
    var tapCount = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var btnCheckAudio: UIButton!
    @IBOutlet weak var btnNext      : UIButton!
    @IBOutlet weak var sliderImage  : UIImageView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: - UI Configuration
    
    func configUI() {
        btnNext.layer.cornerRadius = 8
        btnCheckAudio.buttonPropertiesOne()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Outlet Action
    
    @IBAction func didTapOnCheckAudio(_ sender: UIButton) {
//        ApplicationServiceProvider.shared.resetWindow(in: .Tabbar, for: .MainTBC, from: self)
//        ApplicationServiceProvider.shared.resetWindow(in: .Main, for: .OnAirVC)
        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .BroadcastVC, from: self)
    }
    
    @IBAction func didTapOnNext(_ sender: UIButton) {
        if tapCount == 0 {
            sliderImage.image = UIImage(named: "Slider2")
            tapCount += 1
        } else if tapCount == 1 {
            sliderImage.image = UIImage(named: "Slider3")
            tapCount += 1
        } else {
            ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .LandingVC, from: self)
        }
    }
}
