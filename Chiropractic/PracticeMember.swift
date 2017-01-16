//
//  PracticeMember.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/14/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation
import UIKit

struct PracticeMember: FirebaseType {
    
    let name: String
    let kids: [String]
    let adultOrChild: AdultOrChild
    let paymentType: PaymentType
    var identifier: String?
    let accountType: AccountType
    let signatureImage: UIImage
    let signedInDate: Date
    var endpoint: String = Keys.PracticeMembersEndpoint
    
    var dictionaryCopy: [String : Any] {
        return [
            Keys.nameKey: name,
            Keys.kidsKey: kids,
            Keys.adultOrChildKey: adultOrChild.rawValue,
            Keys.paymentTypeKey: paymentType.rawValue,
            Keys.signatureDataKey: signatureDataFromImage,
            Keys.accountTypeKey: accountType.rawValue,
            Keys.signedInDateKey: signedInDate.timeIntervalSince1970
        ]
    }
    
    var signatureDataFromImage: Data {
        return UIImageJPEGRepresentation(signatureImage, 0.8) ?? Data()
    }
    
    init(name: String,
         kids: [String] = [],
         adultOrChild: AdultOrChild = .adult,
         paymentType: PaymentType = .cash,
         signatureImage: UIImage,
         identifier: String = UUID().uuidString,
         accountType: AccountType = .user,
         signedInDate: Date = Date()) {
        
        self.name = name
        self.kids = kids
        self.adultOrChild = adultOrChild
        self.paymentType = paymentType
        self.signatureImage = signatureImage
        self.identifier = identifier
        self.accountType = accountType
        self.signedInDate = signedInDate
    }
    
    init?(dictionary: [String : Any], identifier: String) {
        guard let name = dictionary[Keys.nameKey] as? String,
            let kids = dictionary[Keys.kidsKey] as? [String],
            let adultOrChildString = dictionary[Keys.adultOrChildKey] as? String,
            let paymentTypeString = dictionary[Keys.paymentTypeKey] as? String,
            let accountTypeString = dictionary[Keys.accountTypeKey] as? String,
            let signatureData = dictionary[Keys.signatureDataKey] as? Data,
            let signatureImage = UIImage(data: signatureData),
            let signedInTimeInterval = dictionary[Keys.signedInDateKey] as? TimeInterval
            else { return nil }
        self.name = name
        self.kids = kids
        self.signatureImage = signatureImage
        self.signedInDate = Date(timeIntervalSince1970: signedInTimeInterval)
        
        switch adultOrChildString {
        case AdultOrChild.child.rawValue:
            self.adultOrChild = .child
        default:
            self.adultOrChild = .adult
        }
        
        switch paymentTypeString {
        case PaymentType.wellness.rawValue:
            self.paymentType = .wellness
        case PaymentType.cash.rawValue:
            self.paymentType = .cash
        case PaymentType.hsa.rawValue:
            self.paymentType = .hsa
        case PaymentType.personalInjury.rawValue:
            self.paymentType = .personalInjury
        default:
            self.paymentType = .insurance
        }
        
        switch accountTypeString {
        case AccountType.admin.rawValue:
            self.accountType = .admin
        case AccountType.office.rawValue:
            self.accountType = .office
        default:
            self.accountType = .user
        }
    }
}
