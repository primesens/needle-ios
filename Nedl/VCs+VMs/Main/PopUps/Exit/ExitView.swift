//
//  ExitView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-04.
//

import UIKit

protocol ExitViewDelegate {
    func didTapOnConfirmExitBtn(action: String)
}

class ExitView: UIView {

    // MARK: - Variables
    static let instance = ExitView()
    var delegate : ExitViewDelegate?
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ExitView", owner: self, options: nil)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commomInit() {
        btnConfirm.layer.cornerRadius = 5
        btnCancel.buttonPropertiesThree()
        // Parentview Properties
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - Show Custom Alert with Actions
    
    func showExitView(from vc: UIViewController) {
        self.delegate = vc as? ExitViewDelegate
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }

    
    enum CustomAlertType {
        case success
        case failure
    }
    
    @IBAction func didTapOnBtnConfirm(_ sender: UIButton) {
        delegate?.didTapOnConfirmExitBtn(action: "Confirm")
        parentView.removeFromSuperview()
    }
    @IBAction func didTapOnBtnCancel(_ sender: UIButton) {
        parentView.removeFromSuperview()
    }
}
