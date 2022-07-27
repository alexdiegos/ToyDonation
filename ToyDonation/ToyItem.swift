//
//  Toy.swift
//  ToyDonation
//
//  Created by Alexandre Silva on 26/07/22.
//  Copyright © 2022 AlexDiegoS. All rights reserved.
//

import Foundation

struct ToyItem {
    var _id: String
    var name: String = ""
    var state: Int = 0
    var donorName: String = ""
    var donorAddress: String = ""
    var donorPhone: String = ""
    
    var stateText: String {
        switch state {
        case 0:
            return "Novo"
        case 1:
            return "Usado"
        default:
            return "Precisa reparo"
        }
    }
}
