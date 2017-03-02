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
    let kids: String
    let adultOrChild: AdultOrChild
    let paymentType: PaymentType
    var identifier: String?
    let signatureImage: UIImage
    let signedInDate: Date
    var endpoint: String = Constants.practiceMembersEndpoint
    
    var dictionaryCopy: JSONDictionary {
        return [
            Constants.nameKey: name,
            Constants.kidsKey: kids,
            Constants.adultOrChildKey: adultOrChild.rawValue,
            Constants.paymentTypeKey: paymentType.rawValue,
            Constants.signatureDataKey: signatureDataFromImageString,
            Constants.signedInDateKey: signedInDate.timeIntervalSince1970
        ]
    }
    
    var signatureDataFromImageString: String {
        let data = UIImageJPEGRepresentation(signatureImage, 0.8) ?? Data()
        return data.base64EncodedString()
    }
    
    init(name: String,
         kids: String,
         adultOrChild: AdultOrChild,
         paymentType: PaymentType,
         signatureImage: UIImage,
         identifier: String,
         accountType: AccountType = .user,
         signedInDate: Date = Date()) {
        
        self.name = name
        self.kids = kids
        self.adultOrChild = adultOrChild
        self.paymentType = paymentType
        self.signatureImage = signatureImage
        self.identifier = identifier
        self.signedInDate = signedInDate
    }
    
    init?(dictionary: JSONDictionary, identifier: String) {
        guard let name = dictionary[Constants.nameKey] as? String,
            let kids = dictionary[Constants.kidsKey] as? String,
            let adultOrChildString = dictionary[Constants.adultOrChildKey] as? String,
            let paymentTypeString = dictionary[Constants.paymentTypeKey] as? String,
            let signatureDataString = dictionary[Constants.signatureDataKey] as? String,
            let signatureData = signatureDataString.data(using: .utf8),
            let signatureImage = UIImage(data: signatureData),
            let signedInTimeInterval = dictionary[Constants.signedInDateKey] as? TimeInterval
            else { return nil }
        self.identifier = identifier
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
    }
}
