//
//  CommentTVCell.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit

class CommentTVCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    func configCell(model: Comments) {
        userImage.layer.cornerRadius = userImage.layer.bounds.width / 2
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.1803921569, blue: 0.2, alpha: 1)
        
        containerView.layer.cornerRadius = 5
        
        lblName.text = model.Name
        lblTime.text = model.Time
        lblComment.text = model.Comment
        userImage.image = model.UserImage
    }
}
