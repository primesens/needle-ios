//
//  CallTVCell.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit

protocol CallTVCellDelegate {
    func didTapOnAddCaller(action: String)
}

class CallTVCell: UITableViewCell {

    var delegate : CallTVCellDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnReact: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    
    func configCell(with model: CallerData) {
        containerView.viewPropertiesOne()
//        userImage.image = model.userImage
        lblName.text = model.id
        
        
    }
    @IBAction func didTapOnBtnAddCaller(_ sender: UIButton) {
        delegate?.didTapOnAddCaller(action: "ACCEPT")
    }
}
