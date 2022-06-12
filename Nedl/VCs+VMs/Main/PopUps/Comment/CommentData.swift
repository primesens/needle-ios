//
//  CommentData.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import Foundation
import UIKit

class CommentData {
    var arrComment: [Comments] = []
    
    func getComments() {
        arrComment.append(Comments(Name: "Jane Dow", UserImage: UIImage(named: "UserImage")!, Comment: "Love the show! What do you think about the new update?", Time: "2m"))
        arrComment.append(Comments(Name: "Jane Dow", UserImage: UIImage(named: "UserImage")!, Comment: "Love the show! What do you think about the new update?", Time: "2m"))
        arrComment.append(Comments(Name: "Jane Dow", UserImage: UIImage(named: "UserImage")!, Comment: "Love the show! What do you think about the new update?", Time: "2m"))
        arrComment.append(Comments(Name: "Jane Dow", UserImage: UIImage(named: "UserImage")!, Comment: "Love the show! What do you think about the new update?", Time: "2m"))
        arrComment.append(Comments(Name: "Jane Dow", UserImage: UIImage(named: "UserImage")!, Comment: "Love the show! What do you think about the new update?", Time: "2m"))
        arrComment.append(Comments(Name: "Jane Dow", UserImage: UIImage(named: "UserImage")!, Comment: "Love the show! What do you think about the new update?", Time: "2m"))
    }
}

struct Comments {
    var Name: String
    var UserImage: UIImage
    var Comment: String
    var Time: String
}
