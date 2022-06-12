//
//  ChangeNumberView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-11.
//

import UIKit

class ChangeNumberView: UIView {

    // MARK: - Variables
    static let instance = ChangeNumberView()
    
    // MARK: - Outlets
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var btnTermsCondition: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ChangeNumberView", owner: self, options: nil)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commomInit() {
        btnConfirm.layer.cornerRadius = 5
        phoneNumberTF.textFieldBoarderOne()
        popupView.viewPropertiesTwo()

        // Parentview Properties
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - Show Custom Alert
    
    func showChangeNumberView() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    
    @IBAction func didTapOnBtnConfirm(_ sender: UIButton) {
        parentView.removeFromSuperview()
        EnterCodeView.instance.showEnterCodeView()
    }
}
