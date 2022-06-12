//
//  SearchData.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-03.
//

import Foundation

class SearchData {
    
    var arrSearchList: [Search] = []

    func getSearch() {
        arrSearchList.append(Search(Name: "Drake", Time: "00.21", Description: "God's Plan - Sirius XM"))
        arrSearchList.append(Search(Name: "Drake", Time: "00.21", Description: "God's Plan - Sirius XM"))
        arrSearchList.append(Search(Name: "Drake", Time: "00.21", Description: "God's Plan - Sirius XM"))
        arrSearchList.append(Search(Name: "Drake", Time: "00.21", Description: "God's Plan - Sirius XM"))
        arrSearchList.append(Search(Name: "Drake", Time: "00.21", Description: "God's Plan - Sirius XM"))
    }
}

struct Search {
    var Name: String
    var Time: String
    var Description: String
}
