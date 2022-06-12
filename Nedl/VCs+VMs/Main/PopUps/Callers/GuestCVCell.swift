//
//  GuestCVCell.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-06-10.
//

import UIKit

class GuestCVCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIImageView!
    @IBOutlet weak var guestAvatarImage: UIImageView!
    @IBOutlet weak var lblGuestName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(with model: CallerData) {
        guestAvatarImage.layer.cornerRadius = guestAvatarImage.layer.bounds.width / 2
    }
    

}
