//
//  SearchTVCell.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import UIKit

class SearchTVCell: UITableViewCell {

    var tapCount = 0
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnPlayStop: UIButton!
    
    func configCell(model: Search) {
        
        lblName.text = model.Name
        lblTime.text = model.Time
        lblDescription.text = model.Description
    }
    
    @IBAction func didTapOnPlay(_ sender: UIButton) {
        if tapCount % 2 == 0 {
            btnPlayStop.setImage(UIImage(named: "PlayIcon"), for: .normal)
        } else if tapCount % 2 == 1 {
            btnPlayStop.setImage(UIImage(named: "StopIcon"), for: .normal)
        }
        
    }
}
