//
//  CountDownTimerVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-28.
//

import UIKit

class CountDownTimerVC: UIViewController {
    
    var timer = Timer()
    var totalSecond = 5
    
    @IBOutlet weak var timerContainerView: UIView!
    @IBOutlet weak var lblCountDown: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    func configUI() {
        timerContainerView.layer.cornerRadius = 8
        btnCancel.layer.cornerRadius = 8
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        lblCountDown.text = String(totalSecond)
        
        if totalSecond != 0 {
            totalSecond -= 1
        } else {
            ApplicationServiceProvider.shared.resetWindow(in: .Main, for: .OnAirVC, from: self)
            endTimer()
        }
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    @IBAction func didTapOnBtnCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
