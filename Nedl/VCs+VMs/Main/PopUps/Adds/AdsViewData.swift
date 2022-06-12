//
//  AdsViewData.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import Foundation
import UIKit

class AdsViewData {
    
    var arrAds: [Ads] = []
    
    func getAds() {
        arrAds.append(Ads(AdImage: UIImage(named: "AdLogo")!, AdName: "Samsung", Decsription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis consequat sagittis tristique consectetur. In elit vitae urna ornare fermentum. Aliquam ut commodo lobortis consectetur pharetra fringilla. Donec ante blandit", AdTimer: "Expires 00.60"))
        arrAds.append(Ads(AdImage: UIImage(named: "AdLogo")!, AdName: "Samsung", Decsription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis consequat sagittis tristique consectetur. In elit vitae urna ornare fermentum. Aliquam ut commodo lobortis consectetur pharetra fringilla. Donec ante blandit", AdTimer: "Expires 00.60"))
        arrAds.append(Ads(AdImage: UIImage(named: "AdLogo")!, AdName: "Samsung", Decsription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis consequat sagittis tristique consectetur. In elit vitae urna ornare fermentum. Aliquam ut commodo lobortis consectetur pharetra fringilla. Donec ante blandit", AdTimer: "Expires 00.60"))
        arrAds.append(Ads(AdImage: UIImage(named: "AdLogo")!, AdName: "Samsung", Decsription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis consequat sagittis tristique consectetur. In elit vitae urna ornare fermentum. Aliquam ut commodo lobortis consectetur pharetra fringilla. Donec ante blandit", AdTimer: "Expires 00.60"))
        arrAds.append(Ads(AdImage: UIImage(named: "AdLogo")!, AdName: "Samsung", Decsription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis consequat sagittis tristique consectetur. In elit vitae urna ornare fermentum. Aliquam ut commodo lobortis consectetur pharetra fringilla. Donec ante blandit", AdTimer: "Expires 00.60"))
    }
}

struct Ads {
    var AdImage: UIImage
    var AdName: String
    var Decsription: String
    var AdTimer: String
}

