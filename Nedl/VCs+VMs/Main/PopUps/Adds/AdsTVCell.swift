//
//  AdsTVCell.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit

class AdsTVCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnHay: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    
    func configCell(model: Ads) {
        baseView.viewPropertiesOne()
        logoImage.layer.cornerRadius = 8
        timerView.layer.cornerRadius = 11
        
        btnHay.buttonPropertiesTwo()
        btnAccept.layer.cornerRadius = 8
        
        logoImage.image = model.AdImage
        lblName.text = model.AdName
        lblDescription.text = model.Decsription
        lblTimer.text = model.AdTimer
    }
    
    override func layoutSubviews() {
        
    }
}
