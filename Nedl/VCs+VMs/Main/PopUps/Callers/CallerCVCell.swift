//
//  CallerCVCell.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-06-10.
//

import UIKit

protocol CallerCVCellDelegate {
    func didTapOnEndCaller(action: String)
}
class CallerCVCell: UICollectionViewCell {

    var delegate: CallerCVCellDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var callerAvatar: UIImageView!
    @IBOutlet weak var btnEndCall: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(with model: CallerData) {
        callerAvatar.layer.cornerRadius = callerAvatar.layer.bounds.width / 2
    }
   
    @IBAction func didTapOnBtnEndCaller(_ sender: UIButton) {
        delegate?.didTapOnEndCaller(action: "END")
    }
}
