//
//  ProfileVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-07.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnSaveProfile: UIButton!
    
    @IBOutlet weak var editProfileImageView: UIImageView!
    
    @IBOutlet weak var btnChangeProfilePhoto: UIButton!
    @IBOutlet weak var btnChangeLocation: UIButton!

    
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var editSaveBtnContainer: UIView!
    
    
    
    
    
    @IBOutlet weak var btnChangeUrl: UIButton!
    @IBOutlet weak var btnCancelChange: UIButton!
    @IBOutlet weak var lblCustomUrl: UILabel!
    @IBOutlet weak var customUrlTF: UITextField!
    @IBOutlet weak var btnShareUrl: UIButton!
    @IBOutlet weak var btnSaveUrl: UIButton!
    @IBOutlet weak var validUrlImage: UIImageView!
    
    @IBOutlet weak var lblHaycount: UILabel!
    @IBOutlet weak var btnGetPaid: UIButton!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var btnChnageNumber: UIButton!
    
    @IBOutlet weak var btnFavouriteInfo: UIButton!
    @IBOutlet weak var lblListners: UILabel!
    
    @IBOutlet weak var btnSignOut: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
        btnEditProfile.isHidden = false
        btnSaveProfile.isHidden = true

        btnEditProfile.buttonPropertiesThree()
        btnSaveProfile.layer.cornerRadius = 8

        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = #colorLiteral(red: 0.6705882353, green: 0, blue: 0, alpha: 1)
        circleView.layer.cornerRadius = circleView.layer.bounds.width / 2

        profileImageView.layer.cornerRadius = profileImageView.layer.bounds.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.3137254902, blue: 0.3294117647, alpha: 1)

        editProfileImageView.isHidden = true
        btnChangeProfilePhoto.isHidden = true
        btnChangeLocation.isHidden = true
        userNameTF.isHidden = true
        lblLocation.isHidden = true

        btnChangeProfilePhoto.buttonPropertiesThree()
        btnChangeLocation.buttonPropertiesThree()
        userNameTF.textFieldBoarderOne()

        editSaveBtnContainer.layer.cornerRadius = 8
        btnChangeUrl.buttonPropertiesThree()
        btnCancelChange.buttonPropertiesThree()
        btnSaveUrl.layer.cornerRadius = 8
        btnShareUrl.layer.cornerRadius = 8
        validUrlImage.isHidden = true

        btnCancelChange.isHidden = true
        btnSaveUrl.isHidden = true

        customUrlTF.textFieldBoarderOne()
        customUrlTF.isHidden = true

        btnGetPaid.buttonPropertiesThree()
        btnChnageNumber.buttonPropertiesThree()

        btnSignOut.buttonPropertiesThree()
    }
    
    @IBAction func didTapOnBtnEdit(_ sender: UIButton) {
        
        btnEditProfile.isHidden = true
        btnSaveProfile.isHidden = false
        
        editProfileImageView.isHidden = false
        btnChangeProfilePhoto.isHidden = false
        btnChangeLocation.isHidden = false
        userNameTF.isHidden = false
        lblLocation.isHidden = false
        
        profileImageView.isHidden = true
        lblUserName.isHidden = true
        
    }
    
    @IBAction func didTapOnBtnSave(_ sender: UIButton) {
        btnEditProfile.isHidden = false
        btnSaveProfile.isHidden = true
        
        editProfileImageView.isHidden = true
        btnChangeProfilePhoto.isHidden = true
        btnChangeLocation.isHidden = true
        userNameTF.isHidden = true
        lblLocation.isHidden = true
        
        profileImageView.isHidden = false
        lblUserName.isHidden = false
        
    }
    
    @IBAction func didTapOnBtnChangeUrl(_ sender: UIButton) {
        btnChangeUrl.isHidden = true
        btnCancelChange.isHidden = false
        customUrlTF.isHidden = false
        btnShareUrl.isHidden = true
        btnSaveUrl.isHidden = false
        validUrlImage.isHidden = false
    }
    
    @IBAction func didTapOnBtnCancelChange(_ sender: UIButton) {
        btnChangeUrl.isHidden = false
        btnCancelChange.isHidden = true
        customUrlTF.isHidden = true
        btnShareUrl.isHidden = false
        btnSaveUrl.isHidden = true
        validUrlImage.isHidden = true
    }
    
    @IBAction func didTapOnBtnShareUrl(_ sender: UIButton) {
//        btnShareUrl.isHidden = true
//        btnSaveUrl.isHidden = false
    }
    
    @IBAction func didTapOnBtnSaveUrl(_ sender: UIButton) {
        btnShareUrl.isHidden = false
        btnSaveUrl.isHidden = true
        customUrlTF.isHidden = true
        
        btnCancelChange.isHidden = true
        btnChangeUrl.isHidden = false
        validUrlImage.isHidden = true
    }
    @IBAction func didTapOnChangeNumber(_ sender: UIButton) {
        ChangeNumberView.instance.showChangeNumberView()
    }
    
    @IBAction func didTapOGetPaid(_ sender: UIButton) {
        ApplicationServiceProvider.shared.pushToViewController(in: .Profile, for: .CashOutVC, from: self)
    }
}
