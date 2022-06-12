//
//  CenterCVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-01.
//

import UIKit

class CenterCVC: UICollectionViewCell {
    
    @IBOutlet weak var centerImage: UIImageView!
    
    func configCell(model: CenterImage) {
        centerImage.image = model.Image
    }
    
    override func layoutSubviews() {
        
    }
}

extension CenterCVC: OnAirDelegate {
    func didTapOnMuteBtn(action: String) {
        centerImage.image = UIImage(named: "Youarecurrentlymuted")
    }
    
    func didTapOnUnMuteBtn(action: String) {
        centerImage.image = UIImage(named: "Mic3")
    }
    
    
}
