//
//  Enums.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/14/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation

enum AdultOrChild: String {
    case adult = "18+"
    case child = "under 18"
}

enum PaymentType: String {
    case wellness = "wellness"
    case cash = "cash"
    case hsa = "H.S.A."
    case personalInjury = "personal injury"
    case insurance = "insurance"
}
